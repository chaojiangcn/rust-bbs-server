use chrono::Local;
use log::trace;
use sea_orm::{DbConn, EntityTrait, NotSet, PaginatorTrait, QueryOrder, Set};
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use validator::Validate;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::{error, Response, success};
use entity::post;
use entity::po::{favorite, ums_user};
use entity::vo::common::PageRes;
use entity::vo::posts::{AddPostReq, AuthorInfo, PostItemRes};
use crate::favorite::FavoriteService;
use super::like::LikeService;

pub struct PostService;


impl PostService {
    pub async fn add_post(db: &DbConn, add_post_req: Json<AddPostReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
        if let Err(e) = add_post_req.validate() {
            let err_str = e.to_string();
            return Ok(Json(error(json!(""), &err_str)));
        }

        let model = post::ActiveModel {
            id: NotSet,
            title: Set(add_post_req.title.clone()),
            content: Set(Option::from(add_post_req.content.clone())),
            cover: Set(Option::from(add_post_req.cover.clone())),
            author_id: Set(add_post_req.author_id.clone()),
            create_time: Set(Local::now().naive_local().into()),
            ..Default::default()
        };

        if let Err(err) = post::Entity::insert(model).exec(db).await {
            trace!("Error inserting post: {}", err);
            return Err(ErrorResponder::from(err));
        };
        Ok(Json(success(json!(()), "add success")))
    }

    /// 获取帖子详情
    pub async fn get_post_detail(db: &DbConn, id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
        let post = post::Entity::find_by_id(id)
            .one(db)
            .await?;
        if post.is_none() {
            return Ok(Json(error(json!(""), "post not found")));
        }
        let user = ums_user::Entity::find_by_id(id).one(db).await?;
        let like_count = LikeService::get_count(db, id).await;
        let favorite_count = FavoriteService::get_count(&(), db, id).await;
        let info = build_post_info(post.unwrap(), user, like_count as i64,  favorite_count as i64, 0);
        Ok(Json(success(json!(info), "success")))
    }

    pub async fn get_list_in_page(db: &DbConn, req: PageParams) -> Result<Json<Response<Value>>, ErrorResponder> {
        // 参数验证
        if let Err(e) = req.validate() {
            let err_str = e.to_string();
            return Ok(Json(error(json!(""), &err_str)));
        }
        let paginator = post::Entity::find()
            .order_by_asc(post::Column::Id)
            .paginate(db, req.size);
        let num_pages = paginator.num_pages().await?;
        let res = paginator.fetch_page(req.page - 1).await;
        let mut resp = PageRes {
            list: vec![],
            total: 0,
        };
        if let Ok(posts) = res {
            for post in posts.iter() {
                let user = ums_user::Entity::find_by_id(post.author_id).one(db).await?;
                let like_count = LikeService::get_count(db, post.id).await;

                let info = build_post_info(post.clone(), user, 0, 0, 0);
                resp.list.push(info);
            };
            resp.total = num_pages;
            return Ok(Json(success(json!(resp), "success")));
        }

        Ok(Json(success(json!(resp), "success")))
    }
}

fn build_post_info(post: post::Model, user: Option<ums_user::Model>, like_count: i64, favorite_count: i64, comment_count: i64) -> PostItemRes {
    let user_info = match user {
        None => AuthorInfo {
            nickname: "momo".to_string(),
            avatar: "url".to_string(),
        },
        Some(u) => AuthorInfo {
            nickname: u.nickname.unwrap_or("momo".to_string()),
            avatar: u.avatar.unwrap_or("url".to_string()),
        },
    };


    let info = PostItemRes {
        id: post.id.to_string(),
        title: post.title.to_string(),
        content: post.content.clone().unwrap_or("".to_string()),
        images: vec![post.cover.clone().unwrap_or("".to_string())],
        date: post.create_time,
        author_info: AuthorInfo {
            nickname: user_info.nickname,
            avatar: user_info.avatar,
        },
        like_count,
        favorite_count,
        comment_count,
    };

    info
}
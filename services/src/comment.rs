use sea_orm::{ColumnTrait, DbConn, EntityTrait, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm::JsonValue::Null;
use sea_orm::prelude::DateTimeUtc;
use sea_orm_rocket::rocket::serde::{Deserialize, Serialize};
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use common::response::{Response, success};
use common::custom_responder::ErrorResponder;
use entity::po::comment;
use entity::po::ums_user;
use entity::vo::comment::AddCommentReq;
use entity::vo::common::PageRes;
use entity::vo::posts::AuthorInfo;

pub struct CommentService;

impl CommentService {
    pub async fn get_count(db: &DbConn, post_id: i32) -> u64 {
        comment::Entity::find()
            .filter(comment::Column::PostId.eq(post_id))
            .count(db)
            .await
            .unwrap()
    }
    pub async fn add_comment(db: &DbConn, data: Json<AddCommentReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = comment::Entity::insert(comment::ActiveModel {
            user_id: sea_orm::Set(data.user_id),
            post_id: sea_orm::Set(data.post_id),
            parent_comment_id: sea_orm::Set(data.parent_comment_id),
            content: sea_orm::Set(data.content.clone()),
            ..Default::default()
        });
        if let Err(err) = res.exec(db).await {
            return Err(ErrorResponder::from(err));
        }
        Ok(Json(success(json!({}), "success")))
    }

    pub async fn delete_comment(db: &DbConn, comment_id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = comment::Entity::delete_by_id(comment_id);
        if let Err(err) = res.exec(db).await {
            return Err(ErrorResponder::from(err));
        }
        Ok(Json(success(json!({}), "")))
    }

    pub async fn get_comment_list_with_page(db: &DbConn, post_id: i32, page: u64, page_size: u64, parent_comment_id: Option<i32>) -> Result<Json<Response<Value>>, ErrorResponder> {
        let mut query = comment::Entity::find()
            .filter(comment::Column::PostId.eq(post_id))
            .order_by_desc(comment::Column::CreatedAt);

        if let Some(parent_comment_id) = parent_comment_id {
            query = query.filter(comment::Column::ParentCommentId.eq(parent_comment_id));
        } else {
            query = query.filter(comment::Column::ParentCommentId.is_null())
        }

        let res =  query.paginate(db, page_size);

        let count = res.num_items().await.unwrap();
        let items = res.fetch_page(page - 1).await.unwrap();
        // build user info
        let mut res: Vec<CommentItem> = vec![];
        for i in 0..items.len() {
            let item = items[i].clone();
            let user = ums_user::Entity::find_by_id(item.user_id).one(db).await?;
            let user_info = match user {
                None => AuthorInfo {
                    nickname: "momo".to_string(),
                    avatar: "url".to_string(),
                    user_id: 0,
                },
                Some(u) => AuthorInfo {
                    nickname: u.nickname.unwrap(),
                    avatar: u.avatar.unwrap(),
                    user_id: u.id,
                },
            };
            let c_item = CommentItem {
                id: item.id,
                user_id: item.user_id,
                post_id,
                parent_comment_id: None,
                content: item.content.clone(),
                created_at: item.created_at,
                is_deleted: item.is_deleted,
                user_info,
            };

            res.push(c_item);
        }

        let resp = PageRes {
            list: res,
            total: count,
        };
        Ok(Json(success(json!(resp), "")))
    }
}

#[derive(Deserialize, Serialize)]
pub struct CommentItem {
    pub id: i32,
    pub user_id: i32,
    pub post_id: i32,
    pub parent_comment_id: Option<i32>,
    pub content: String,
    pub created_at: Option<DateTimeUtc>,
    pub is_deleted: i32,
    pub user_info: AuthorInfo,
}

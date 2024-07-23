use sea_orm::{ColumnTrait, DbConn, EntityTrait, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use common::response::{Response, success};
use common::custom_responder::ErrorResponder;
use entity::po::comment;
use entity::vo::comment::AddCommentReq;
use entity::vo::common::PageRes;

pub struct CommentService;

impl CommentService {

    pub  async fn get_count(db: &DbConn, post_id: i32) -> u64 {
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

    pub async fn get_comment_list_with_page(db: &DbConn, post_id: i32, page: u64, page_size: u64) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = comment::Entity::find()
            .filter(comment::Column::PostId.eq(post_id))
            .order_by_desc(comment::Column::CreatedAt)
            .paginate(db, page_size);
        let count = res.num_items().await.unwrap();
        let items = res.fetch_page(page).await.unwrap();
        let resp = PageRes {
            list: items,
            total: count,
        };
        Ok(Json(success(json!(resp), "")))
    }
}
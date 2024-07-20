use sea_orm::{ColumnTrait, DbConn, EntityTrait, QueryFilter};
use common::custom_responder::ErrorResponder;
use entity::po::follow;
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use common::response::{Response, success};

pub struct FollowService;

impl FollowService {
    pub async fn follow_handle(db: &DbConn, follower_id: i32, following_id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = follow::Entity::insert(follow::ActiveModel {
            follower_id: sea_orm::Set(follower_id),
            following_id: sea_orm::Set(following_id),
            ..Default::default()
        });
        if let Err(err) = res.exec(db).await {
            return Err(ErrorResponder::from(err));
        };
        Ok(Json(success(json!({
            "follower_id": follower_id,
            "following_id": following_id
        }), "关注成功")))
    }

    pub async fn un_follow_handle(db: &DbConn, follower_id: i32, following_id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = follow::Entity::delete_many()
            .filter(follow::Column::FollowerId.eq(follower_id))
            .filter(follow::Column::FollowingId.eq(following_id));
        if let Err(err) = res.exec(db).await {
            return Err(ErrorResponder::from(err));
        }
        Ok(Json(success(json!({}), "success")))
    }
}
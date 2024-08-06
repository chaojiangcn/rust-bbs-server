use common::custom_responder::ErrorResponder;
use common::response::{error, success, Response};
use entity::po::favorite;
use sea_orm::{ColumnTrait, DbConn, EntityTrait, PaginatorTrait, QueryFilter};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use sea_orm_rocket::rocket::serde::json::{Json, Value};

pub struct FavoriteService;

impl FavoriteService {
    pub async fn get_count(db: &DbConn, post_id: i32) -> u64 {
        let res = favorite::Entity::find()
            .filter(favorite::Column::PostId.eq(post_id))
            .count(db)
            .await;
        return if res.is_err() { 0 } else { res.unwrap() };
    }

    pub async fn favorite_handle(
        db: &DbConn,
        post_id: i32,
        user_id: i32,
    ) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = favorite::Entity::insert(favorite::ActiveModel {
            post_id: sea_orm::Set(post_id),
            user_id: sea_orm::Set(user_id),
            ..Default::default()
        });

        if let Err(err) = res.exec(db).await {
            return Err(ErrorResponder::from(err));
        }

        Ok(Json(success(json!({}), "success")))
    }

    pub async fn un_favorite_handle(
        db: &DbConn,
        post_id: i32,
        user_id: i32,
    ) -> Result<Json<Response<Value>>, ErrorResponder> {
        let res = favorite::Entity::delete_many()
            .filter(favorite::Column::PostId.eq(post_id))
            .filter(favorite::Column::UserId.eq(user_id))
            .exec(db)
            .await?
            .rows_affected;
        if res == 0 {
            return Ok(Json(error(json!(""), "未找到该记录")));
        }
        Ok(Json(success(json!({}), "success")))
    }

    pub async fn check_favorite(db: &DbConn, post_id: i32, user_id: i32) -> Result<bool, ErrorResponder> {
        let count = favorite::Entity::find()
            .filter(favorite::Column::PostId.eq(post_id))
            .filter(favorite::Column::UserId.eq(user_id))
            .count(db)
            .await;
        if count.is_err() {
            return Ok(false);
        }

        return Ok(count.unwrap() > 0);
    }
}

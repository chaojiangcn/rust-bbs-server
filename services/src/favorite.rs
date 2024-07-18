use async_trait::async_trait;
use common::{custom_responder::ErrorResponder, response::Response};
use sea_orm::DbConn;
use sea_orm_rocket::rocket::serde::json::{Json, Value};

#[async_trait]
pub trait FavoriteService: Send + Sync {
    // async fn get_count(&self, db: &DbConn, post_id: i32) -> u64;

    async fn favorite_handle(
        &self,
        db: &DbConn,
        post_id: i32,
        user_id: i32,
    ) -> Result<Json<Response<Value>>, ErrorResponder>;

    async fn un_favorite_handle(
        &self,
        db: &DbConn,
        post_id: i32,
        user_id: i32,
    ) -> Result<Json<Response<Value>>, ErrorResponder>;
}



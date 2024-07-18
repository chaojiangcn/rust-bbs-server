use rocket::serde::json::{Json, Value};
use rocket::State;
use sea_orm::DatabaseConnection;
use common::custom_responder::ErrorResponder;
use common::response::Response;
use entity::vo::like::AddLikeReq;
use service::favorite::FavoriteService;

#[post("/favorite", data = "<data>")]
pub async fn favorite(db: &State<DatabaseConnection>, data: Json<AddLikeReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    FavoriteService::favorite_handle(db, data.post_id, data.user_id).await
}

#[post("/un_favorite", data = "<data>")]
pub async fn un_favorite(db: &State<DatabaseConnection>, data: Json<AddLikeReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    FavoriteService::un_favorite_handle(db, data.post_id, data.user_id).await
}
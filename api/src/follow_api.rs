use rocket::serde::json::{Json, Value};
use rocket::State;
use sea_orm::DatabaseConnection;
use common::custom_responder::ErrorResponder;
use common::response::Response;
use entity::vo::follow::AddFollowReq;
use service::follow::FollowService;

#[post("/follow", format = "json", data = "<data>")]
pub async fn follow(db: &State<DatabaseConnection>, data: Json<AddFollowReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    FollowService::follow_handle(db, data.following_id, data.follower_id).await
}

#[post("/unfollow", format = "json", data = "<data>")]
pub async fn un_follow(db: &State<DatabaseConnection>, data: Json<AddFollowReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    FollowService::un_follow_handle(db, data.following_id, data.follower_id).await
}
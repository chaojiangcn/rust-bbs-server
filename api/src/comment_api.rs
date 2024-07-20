use rocket::serde::json::{Json, Value};
use rocket::State;
use sea_orm::DatabaseConnection;
use common::custom_responder::ErrorResponder;
use common::response::Response;
use entity::vo::comment::AddCommentReq;
use service::comment::CommentService;

#[get("/list/<post_id>/<page>/<size>")]
pub async fn get_list_with_page(db: &State<DatabaseConnection>, post_id: i32, page: u64, size: u64) -> Result<Json<Response<Value>>, ErrorResponder> {
    CommentService::get_comment_list_with_page(db, post_id, page, size).await
}

#[post("/add", data = "<data>")]
pub async fn add_comment(db: &State<DatabaseConnection>, data: Json<AddCommentReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    CommentService::add_comment(db, data).await
}

#[delete("/delete/<comment_id>")]
pub async fn delete_comment(db: &State<DatabaseConnection>, comment_id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
    CommentService::delete_comment(db, comment_id).await
}
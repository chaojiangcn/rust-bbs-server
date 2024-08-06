use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use rocket::State;
use sea_orm::DatabaseConnection;
use common::auth::Token;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::{error, Response};
use entity::vo::posts::AddPostReq;

use service::post::PostService;

#[get("/list?<page>&<size>")]
pub async fn post_list(
    db: &State<DatabaseConnection>,
    page: u64,
    size: u64,
) -> Result<Json<Response<Value>>, ErrorResponder> {
    PostService::get_list_in_page(db, PageParams { page, size, keyword: None }).await
}


#[get("/detail/<id>")]
pub async fn get_post_detail(token: Token, db: &State<DatabaseConnection>, id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
    PostService::get_post_detail(token, db, id).await
}

#[post("/add", data = "<add_post_req>")]
pub async fn add_post(db: &State<DatabaseConnection>, add_post_req: Json<AddPostReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    PostService::add_post(db, add_post_req).await
}
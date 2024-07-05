use rocket::http::Status;
use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use rocket::State;
use rocket::time::format_description::parse;
use sea_orm::DatabaseConnection;
use sea_orm_rocket::Connection;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::{Response, success};

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
pub async fn get_post_detail(db: &State<DatabaseConnection>, id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
    PostService::get_post_detail(db, id).await
}
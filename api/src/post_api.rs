use std::os::unix::raw::uid_t;
use jsonwebtoken::{decode, DecodingKey, Validation};
use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use rocket::State;
use sea_orm::DatabaseConnection;
use common::auth::{Claims, Token};
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


#[derive(FromForm)]
struct Person {
    uid: Option<i32>,
    id: i32,
}
#[get("/detail?<person..>")]
pub async fn get_post_detail(db: &State<DatabaseConnection>, person: Option<Person>) -> Result<Json<Response<Value>>, ErrorResponder> {
    match person {
        None => {
            return Ok(Json(error(json!(""), "id is required")));
        }
        Some(item) => {
            PostService::get_post_detail(db, item.uid, item.id).await
        }
    }

}

#[post("/add", data = "<add_post_req>")]
pub async fn add_post(db: &State<DatabaseConnection>, add_post_req: Json<AddPostReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    PostService::add_post(db, add_post_req).await
}
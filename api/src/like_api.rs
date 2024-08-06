use rocket::serde::json::{Json, Value};
use rocket::State;
use sea_orm::DatabaseConnection;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::Response;
use entity::vo::like::{AddLikeReq, AddUnLikeReq};
use service::like::LikeService;


#[get("/list?<page>&<size>")]
pub async fn get_list_in_page(db: &State<DatabaseConnection>, page: u64, size: u64) -> Result<Json<Response<Value>>, ErrorResponder> {
    let page_params = PageParams {
        page,
        size,
        keyword: None,
    };
    LikeService::get_list_in_page(db, page_params).await
}

#[post("/like", data = "<data>")]
pub async fn like(db: &State<DatabaseConnection>, data: Json<AddLikeReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    LikeService::like(db, data).await
}

#[post("/unlike", data = "<data>")]
pub async fn unlike(db: &State<DatabaseConnection>, data: Json<AddUnLikeReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    LikeService::unlike(db, data).await
}
use std::sync::Arc;
use rocket::serde::json::{Json, Value};
use rocket::State;
use sea_orm::DatabaseConnection;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::Response;


#[get("/list?<page>&<size>")]
pub async fn get_list_in_page(db: &State<DatabaseConnection>, page: u64, size: u64) -> Result<Json<Response<Value>>, ErrorResponder> {
    let page_params = PageParams {
        page,
        size,
        keyword: None,
    };

    service::like::get_list_in_page(db, page_params).await
}
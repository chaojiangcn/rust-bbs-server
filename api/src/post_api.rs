use rocket::http::Status;
use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use rocket::State;
use rocket::time::format_description::parse;
use sea_orm_rocket::Connection;
use common::pool::Db;
use common::request::PageParams;
use common::response::{Response, success};

use service::post::PostService;
#[get("/list?<page>&<size>")]
pub async fn post_list(
    conn: Connection<'_, Db>,
    page: Option<u64>,
    size: Option<u64>
) -> Result<Json<Value>, Status> {
    println!("page: {:?},size:{:?}",page, size);

    let db = conn.into_inner();

    let page  = page.unwrap_or(1);
    if page == 0 {
        return Err(Status::BadRequest);
    }

    let size  = size.unwrap_or(10);
    if size == 0 {
        return Err(Status::BadRequest);
    }
    let (posts, num_pages) = PostService::get_list_in_page(db, PageParams {page, size, keyword: None })
        .await
        .expect("Cannot find posts in page");

    Ok(Json(json!({
        "page": page,
        "size": size,
        "num_posts": num_pages,
        "post": posts,
    })))
}
use rocket::form::Form;
use rocket::futures::future::ok;
use rocket::request::FlashMessage;
use rocket::response::{Flash, Redirect};
use rocket::serde::json::{json, Json, Value};
use rocket::State;

use sea_orm_rocket::Connection;
use common::pool::Db;
use common::response::{Response, success};

use entity::post_temp;
use entity::post_temp::Model;
use service::{Mutation, Query};


const DEFAULT_POSTS_PER_PAGE: u64 = 5;

#[post("/", data = "<post_form>")]
pub async fn create(conn: Connection<'_, Db>, post_form: Form<post_temp::Model>) -> Flash<Redirect> {
    let db = conn.into_inner();

    let form = post_form.into_inner();

    Mutation::create_post(db, form)
        .await
        .expect("could not insert post");

    Flash::success(Redirect::to("/"), "Post successfully added.")
}

#[post("/<id>", data = "<post_form>")]
pub async fn update(
    conn: Connection<'_, Db>,
    id: i32,
    post_form: Form<post_temp::Model>,
) -> Flash<Redirect> {
    let db = conn.into_inner();

    let form = post_form.into_inner();

    Mutation::update_post_by_id(db, id, form)
        .await
        .expect("could not update post");

    Flash::success(Redirect::to("/"), "Post successfully edited.")
}

#[get("/?<page>&<posts_per_page>")]
pub async fn list(
    conn: Connection<'_, Db>,
    page: Option<u64>,
    posts_per_page: Option<u64>,
    flash: Option<FlashMessage<'_>>,
) -> Result<Json<Value>, String> {
    let db = conn.into_inner();

    // Set page number and items per page
    let page = page.unwrap_or(1);
    if page == 0 {
        return Err("Page number cannot be zero".to_string());
    }
    let posts_per_page = posts_per_page.unwrap_or(DEFAULT_POSTS_PER_PAGE);
    if page == 0 {
        panic!("Page number cannot be zero");
    }

    let (posts, num_pages) = Query::find_posts_in_page(db, page, posts_per_page)
        .await
        .expect("Cannot find posts in page");


    Ok(Json(json!({
        "page": page,
        "posts_per_page": posts_per_page,
        "num_pages": num_pages,
        "posts": posts,
        "flash": flash.map(FlashMessage::into_inner),
    })))
}

#[get("/<id>")]
pub async fn edit(conn: Connection<'_, Db>, id: i32) -> Json<Response<Value>> {
    let db = conn.into_inner();

    let post: Option<post_temp::Model> = Query::find_post_by_id(db, id)
        .await
        .expect("could not find post");
    Json(success(json!(post), "success"))
}

#[delete("/<id>")]
pub async fn delete(conn: Connection<'_, Db>, id: i32) -> Flash<Redirect> {
    let db = conn.into_inner();

    Mutation::delete_post(db, id)
        .await
        .expect("could not delete post");

    Flash::success(Redirect::to("/"), "Post successfully deleted.")
}

#[delete("/")]
pub async fn destroy(conn: Connection<'_, Db>) -> Result<(), rocket::response::Debug<String>> {
    let db = conn.into_inner();

    Mutation::delete_all_posts(db)
        .await
        .map_err(|e| e.to_string())?;

    Ok(())
}
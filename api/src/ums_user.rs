use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use sea_orm::sea_query::IdenList;
use sea_orm_rocket::Connection;
use common::pool::Db;
use common::response::{Response, success};
use entity::prelude::UmsUser;
use service;
use entity::ums_user;

#[get("/<id>")]
pub async fn read(conn: Connection<'_, Db>, id: i32) -> Json<Response<Value>> {
    let db = conn.into_inner();

    let user: Option<ums_user::Model> = service::ums_user::get_user_info_by_id(db, id)
        .await
        .expect("could not find post");

    Json(success(json!(user), "success"))
}
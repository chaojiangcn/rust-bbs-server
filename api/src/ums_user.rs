use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use rocket::State;
use sea_orm::DatabaseConnection;
use sea_orm::sea_query::IdenList;
use sea_orm_rocket::Connection;
use bcrypt::{hash, verify};
use common::auth::{Claims, Token};

use common::response::{Response, success};
use common::custom_responder::ErrorResponder;
use entity::prelude::UmsUser;
use service;
use entity::po::ums_user;
use entity::vo::ums_user::{AddUserReq, LoginReq};

#[post("/<id>")]
pub async fn read(_token: Token, db: &State<DatabaseConnection>, id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
   service::ums_user::get_user_info_by_id(db, id).await
}

#[post("/signup", data = "<add_user_req>")]
pub async fn signup(db: &State<DatabaseConnection>, add_user_req: Json<AddUserReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    let res = service::ums_user::register(db, add_user_req.into_inner()).await;
    res
}

#[post("/login", data = "<login_req>")]
pub async fn login(db: &State<DatabaseConnection>, login_req: Json<LoginReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
   service::ums_user::login(db, login_req.into_inner()).await
}

pub fn logout() {}
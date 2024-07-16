use rocket::serde::json::{Json, Value};
use rocket::State;
use sea_orm::DatabaseConnection;
use common::auth::{Token};

use common::response::{Response};
use common::custom_responder::ErrorResponder;
use service;
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
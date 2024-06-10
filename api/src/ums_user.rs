use rocket::serde::json::{Json, Value};
use rocket::serde::json::serde_json::json;
use rocket::State;
use sea_orm::DatabaseConnection;
use sea_orm::sea_query::IdenList;
use sea_orm_rocket::Connection;
use bcrypt::{hash, verify};

use common::response::{Response, success};
use common::custom_responder::ErrorResponder;
use entity::prelude::UmsUser;
use service;
use entity::po::ums_user;
use entity::vo::ums_user::AddUserReq;

#[get("/<id>")]
pub async fn read(db: &State<DatabaseConnection>, id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
    let user = service::ums_user::get_user_info_by_id(db, id).await?;


    Ok(Json(success(json!(user), "success")))
}

#[post("/register", data = "<add_user_req>")]
pub async fn register(db: &State<DatabaseConnection>, add_user_req: Json<AddUserReq>) -> Result<Json<Response<Value>>, ErrorResponder> {
    let _ = service::ums_user::register(db, add_user_req.into_inner()).await;
    Ok(Json(success(json!(()), "success")))
}

pub fn login() {

    let psd = "123";
    // 使用 bcrypt 对密码进行哈希处理
    let hashed_password = hash(psd.as_bytes(), bcrypt::DEFAULT_COST).unwrap();

    let password = "sdfsfewrwer7234";
    let stored_hash = String::from(Vec::from(password.clone())).unwrap();

    // 验证密码是否正确
    match verify(hashed_password.as_bytes(), stored_hash.as_bytes()) {
        Ok(is_correct) => {
            if is_correct {
                println!("Password is correct!");
            } else {
                println!("Password is incorrect!");
            }
        },
        Err(e) => {
            println!("Error verifying password: {}", e);
        }
    }

    Json("");
}

pub fn logout() {}
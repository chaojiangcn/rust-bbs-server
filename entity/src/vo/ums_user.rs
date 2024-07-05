use rocket::serde::{Deserialize, Serialize};
use validator::Validate;

#[derive(Debug, Validate, Deserialize, Serialize )]
pub struct AddUserReq {
    #[validate(email)]
    pub email: String,
    #[validate(length(min = 8))]
    pub password: String,
}
#[derive(Validate, Deserialize, Serialize)]
pub struct LoginReq {
    #[validate(email)]
    pub email: String,
    pub password: String,
}
#[derive(Deserialize, Serialize)]
pub struct LoginRes {
    pub token: String,
    pub uid: i32,
    pub nickname: String,
    pub avatar: String,
}


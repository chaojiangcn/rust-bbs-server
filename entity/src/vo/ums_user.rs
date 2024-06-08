use rocket::serde::Deserialize;
use validator::Validate;

#[derive(Deserialize, Validate )]
#[serde(crate = "rocket::serde")]
pub struct AddUserReq {
    #[validate(email)]
    pub email: String,
    pub password: String,
}
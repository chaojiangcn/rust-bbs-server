use rocket::serde::{Deserialize, Serialize};
use validator::Validate;

#[derive(Validate, Deserialize, Serialize)]
pub struct AddLikeReq {
    #[validate(range(min = 1))]
    pub user_id: i32,
    pub post_id: i32,
}
#[derive(Validate, Deserialize, Serialize)]
pub struct AddUnLikeReq {
    #[validate(range(min = 1))]
    pub user_id: i32,
    pub post_id: i32,
}
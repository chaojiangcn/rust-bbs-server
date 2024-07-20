use rocket::serde::{Deserialize, Serialize};
use validator::Validate;

#[derive(Validate, Deserialize, Serialize)]
pub struct AddFollowReq {
    #[validate(range(min = 1))]
    pub follower_id: i32,
    pub following_id: i32,
}
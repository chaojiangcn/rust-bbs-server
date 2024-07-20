use rocket::serde::{Deserialize, Serialize};
use validator::Validate;

#[derive(Validate, Deserialize, Serialize)]
pub struct AddCommentReq {
    #[validate(range(min = 1))]
    pub user_id: i32,
    pub post_id: i32,
    pub parent_comment_id: Option<i32>,
    pub content: String,
}
use rocket::serde::{Deserialize, Serialize};
use sea_orm::prelude::DateTime;
use validator::Validate;

#[derive(Deserialize, Serialize)]
pub struct AuthorInfo {
    pub nickname: String,
    pub avatar: String,
}
#[derive(Deserialize, Serialize)]
pub struct PostItemRes {
    pub id: String,
    pub title: String,
    pub content: String,
    pub images: Vec<String>,
    pub date: Option<DateTime>,
    pub author_info: AuthorInfo,
    pub like_count: i64,
    pub comment_count: i64,
    pub favorite_count: i64,
}

#[derive(Validate, Deserialize, Serialize)]
pub struct AddPostReq {
    #[validate(length(min = 1))]
    pub title: String,
    pub author_id: i32,
    pub content: String,
    pub tag_id: Option<i32>,
    pub cover: String,
}
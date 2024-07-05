use rocket::serde::{Deserialize, Serialize};
use sea_orm::prelude::DateTime;

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
}

#[derive(Deserialize, Serialize)]
pub struct PageRes{
    pub list: Vec<PostItemRes>,
    pub total: u64,
}
use rocket::FromForm;
use rocket::serde::{Deserialize, Serialize};
use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, Eq, DeriveEntityModel, Deserialize, Serialize, FromForm)]
#[serde(crate = "rocket::serde")]
#[sea_orm(table_name = "posts")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i32,
    pub title: String,
    #[sea_orm(column_type = "Text")]
    pub text: String,
}
///
struct PostItemProps {
    pub id: i32,
    pub title: String,
    pub images: Option<Vec<String>>,
    pub date: String,
    pub author_info: AuthorInfo,
    pub like_count: i32,
    pub comment_count: i32,
    pub text: String,
}

struct AuthorInfo {
    nickname: String,
    avatar: String,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}

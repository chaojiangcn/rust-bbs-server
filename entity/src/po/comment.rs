//! `SeaORM` Entity. Generated by sea-orm-codegen 0.12.15

use sea_orm::entity::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq, Serialize, Deserialize)]
#[sea_orm(table_name = "comment")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i32,
    pub user_id: i32,
    pub post_id: i32,
    pub parent_comment_id: Option<i32>,
    #[sea_orm(column_type = "Text")]
    pub content: String,
    pub created_at: Option<DateTimeUtc>,
    pub is_deleted: i32,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(
        belongs_to = "Entity",
        from = "Column::ParentCommentId",
        to = "Column::Id",
        on_update = "NoAction",
        on_delete = "Cascade"
    )]
    SelfRef,
    #[sea_orm(
        belongs_to = "super::post::Entity",
        from = "Column::PostId",
        to = "super::post::Column::Id",
        on_update = "NoAction",
        on_delete = "Cascade"
    )]
    Post,
    #[sea_orm(
        belongs_to = "super::ums_user::Entity",
        from = "Column::UserId",
        to = "super::ums_user::Column::Id",
        on_update = "NoAction",
        on_delete = "Cascade"
    )]
    UmsUser,
}

impl Related<super::post::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Post.def()
    }
}

impl Related<super::ums_user::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::UmsUser.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
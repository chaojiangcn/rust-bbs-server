//! `SeaORM` Entity. Generated by sea-orm-codegen 0.12.15

use sea_orm::entity::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq, Serialize, Deserialize)]
#[sea_orm(table_name = "user_actions")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i32,
    pub user_id: i32,
    pub action_id: i32,
    pub action_timestamp: Option<DateTimeUtc>,
    #[sea_orm(column_type = "Text", nullable)]
    pub details: Option<String>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(
        belongs_to = "super::actions::Entity",
        from = "Column::ActionId",
        to = "super::actions::Column::Id",
        on_update = "NoAction",
        on_delete = "Cascade"
    )]
    Actions,
    #[sea_orm(
        belongs_to = "super::ums_user::Entity",
        from = "Column::UserId",
        to = "super::ums_user::Column::Id",
        on_update = "NoAction",
        on_delete = "Cascade"
    )]
    UmsUser,
}

impl Related<super::actions::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Actions.def()
    }
}

impl Related<super::ums_user::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::UmsUser.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}

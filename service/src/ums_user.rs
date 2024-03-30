use ::entity::{ums_user, ums_user::Entity as UmsUser};
use sea_orm::*;


pub async fn get_user_info_by_id(db: &DbConn, id: i32) -> Result<Option<ums_user::Model>, DbErr> {
    UmsUser::find_by_id(id).one(db).await
}

pub async fn get_user_info_by_name(db: &DbConn, name: String) -> Result<Option<ums_user::Model>, DbErr> {
    UmsUser::find()
        .filter(ums_user::Column::Nickname.eq(name))
        .one(db)
        .await
}

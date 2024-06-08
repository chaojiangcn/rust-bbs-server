use chrono::Local;
use ::entity::po::ums_user;
use ::entity::vo::ums_user::AddUserReq;
use ::entity::po::ums_user::Model;
use sea_orm::*;
use sea_orm::ActiveValue::Set;
use sea_orm::sea_query::IndexType::Hash;
use sea_orm_rocket::rocket::trace;
use bcrypt::hash;
use common::custom_responder::ErrorResponder;
use common::str_util::generate_random_ascii_string;



pub async fn get_user_info_by_id(db: &DbConn, id: i32) -> Result<Model, ErrorResponder> {
    let res = ums_user::Entity::find_by_id(id).one(db).await?;
    Ok(
        if let Some(res) = res {
            res.into()
        } else {
            return Err("no get_user_info_by_id ".to_string().into());
        }
    )
}

pub async fn get_user_info_by_name(db: &DbConn, name: String) -> Result<Option<Model>, DbErr> {
    ums_user::Entity::find()
        .filter(ums_user::Column::Nickname.eq(name))
        .one(db)
        .await
}

pub async fn register(db: &DbConn, rep: AddUserReq) -> Result<(), ErrorResponder> {
    let psd = hash(rep.password.clone().as_bytes(), bcrypt::DEFAULT_COST).unwrap() ;
    let name = generate_random_ascii_string(2);
    let nickname = format!("rust{}", name);
    let model = ums_user::ActiveModel {
        id: NotSet,
        email: Set(Option::from(rep.email)),
        password: Set(Option::from(psd)),
        nickname: Set(Option::from(nickname)),
        create_time: Set(Local::now().naive_local()),
        ..Default::default()
    };

    // ums_user::Entity::insert(model).exec(db).await;
    if let Err(err) = ums_user::Entity::insert(model).exec(db).await {
        trace!("Error------");
        return Err(ErrorResponder::from(err));
    };
    Ok(())
}
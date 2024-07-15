use chrono::Local;
use ::entity::po::ums_user;
use ::entity::vo::ums_user::AddUserReq;
use ::entity::po::ums_user::Model;
use ::entity::vo::ums_user::LoginRes;
use ::entity::vo::ums_user::LoginReq;
use sea_orm::ActiveValue::Set;
use sea_orm_rocket::rocket::trace;
use bcrypt::{hash, verify};
use jsonwebtoken::{encode, EncodingKey, Header};
use sea_orm::*;
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use validator::Validate;
use common::auth::Claims;
use common::custom_responder::ErrorResponder;
use common::response::{error, Response, success};
use common::str_util::generate_random_ascii_string;


pub async fn get_user_info_by_id(db: &DbConn, id: i32) -> Result<Json<Response<Value>>, ErrorResponder> {
    let res = ums_user::Entity::find_by_id(id).one(db).await?;
    if let Some(res) = res {
        Ok(Json(success(json!(res), "success")))
    } else {
        Ok(Json(error(json!(()), "未找到该用户")))
    }
}

pub async fn get_user_info_by_name(db: &DbConn, name: String) -> Result<Vec<Model>, DbErr> {
    ums_user::Entity::find()
        .filter(ums_user::Column::Username.eq(name))
        .all(db)
        .await
}

pub async fn get_user_info_by_email(db: &DbConn, email: String) -> Result<Vec<Model>, DbErr> {
    ums_user::Entity::find()
        .filter(ums_user::Column::Email.eq(email))
        .all(db)
        .await
}

pub async fn login(db: &DbConn, login_req: LoginReq) -> Result<Json<Response<Value>>, ErrorResponder> {
    let user = get_user_info_by_email(db, login_req.email.clone()).await?;

    if user.is_empty() {
        return Ok(Json(error(json!(""), "该用户未注册")));
    }

    let password = &user[0].password.clone().unwrap();

    // 验证密码是否正确
    match verify(login_req.password, password) {
        Ok(is_correct) => {
            if is_correct {
                println!("Password is correct!");
            } else {
                println!("Password is incorrect!");
                return Ok(Json(error(json!(""), "密码不匹配")));
            }
        }
        Err(e) => {
            println!("Error verifying password: {}", e);
        }
    }

    let now = Local::now().timestamp() as usize;

    // 验证通过生成 Jwt
    let claims = Claims {
        sub: login_req.email.clone(),
        exp: now + 3600,
    };

    let token = encode(&Header::default(), &claims, &EncodingKey::from_secret("rust_bbs".as_ref()))?;

    let res = LoginRes {
        token,
        uid: user[0].id,
        nickname: user[0].nickname.clone().unwrap_or("".to_string()),
        avatar: user[0].avatar.clone().unwrap_or("".to_string()),
    };
    Ok(Json(success(json!((res)), "login success")))
}

pub async fn register(db: &DbConn, req: AddUserReq) -> Result<Json<Response<Value>>, ErrorResponder> {
    // 参数验证
    if let Err(e) = req.validate() {
        let err_str = e.to_string();
        return Ok(Json(error(json!(""), &err_str)));
    }

    let psd = hash(req.password.clone(), bcrypt::DEFAULT_COST).unwrap();
    let name = generate_random_ascii_string(2);
    // 生成随机昵称(rustXXX)
    let nickname = format!("rust{}", name);

    let model = ums_user::ActiveModel {
        id: NotSet,
        email: Set(Option::from(req.email)),
        password: Set(Option::from(psd)),
        nickname: Set(Option::from(nickname)),
        create_time: Set(Local::now().naive_local().into()),
        ..Default::default()
    };

    if let Err(err) = ums_user::Entity::insert(model).exec(db).await {
        trace!("Error inserting user: {}", err);
        return Err(ErrorResponder::from(err));
    };
    Ok(Json(success(json!(()), "signup success")))
}
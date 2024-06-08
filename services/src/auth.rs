use serde::{Deserialize, Serialize};
use validator::{Validate};


#[derive(Debug, Validate, Deserialize, Serialize)]
pub struct ReqLogin {
    #[validate(length(min = 1, message = "用户名必填"))]
    pub username: String,
    #[validate(length(min = 1, message = "密码必填"))]
    pub password: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct RespLogin {
    pub name: String,
    pub role: i8,
    pub auth_token: String,
}


// pub async fn login(db: &DbConn, req: ReqLogin) -> RespLogin {
//
//     // let ret = ums_user::get_user_info_by_name(db, req.username)
//     //     .await;
//     // let model = match ret {
//     //     None => return {},
//     //     Some(v) => v,
//     // };
// }
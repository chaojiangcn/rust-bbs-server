#[macro_use]
extern crate rocket;

mod ums_user;
mod post_api;
mod like_api;

use rocket::fairing::Fairing;
use rocket::http::Method;
use sea_orm_rocket::Database;
use common::setup::set_up_db;
use crate::ums_user::{login, read, signup};
use crate::post_api::{get_post_detail, post_list};
use rocket_cors::{AllowedHeaders, AllowedOrigins};


#[rocket::main]
async fn start() -> Result<(), rocket::Error> {

    // let allowed_origins = AllowedOrigins::some_exact(&["https://www.acme.com"]);
    let allowed_origins = AllowedOrigins::all();
    let allowed_headers = AllowedHeaders::some(&["Content-Type", "Authorization", "X-Custom-Header"]); // 允许特定的头字段

    // You can also deserialize this
    let cors = rocket_cors::CorsOptions {
        allowed_origins,
        allowed_methods: vec![Method::Get, Method::Post].into_iter().map(From::from).collect(),
        allowed_headers,
        allow_credentials: true,
        ..Default::default()
    };

    // 处理 rocket_cors::Error
    let cors = match cors.to_cors() {
        Ok(cors) => cors,
        Err(_) => {
            // 这里可以记录错误或进行其他错误处理工作
            return Err(rocket::Error::from(rocket::error::ErrorKind::Io(std::io::Error::new(
                std::io::ErrorKind::Other,
                "Failed to create CORS configuration",
            ))));
        }
    };

    let db = match set_up_db().await {
        Ok(db) => db,
        Err(err) => panic!("DB connection is Error: {} , Please again", err),
    };



    rocket::build()
        // 连接数据库
        // .attach(Db::init())
        .manage(db)
        .mount("/post", routes![post_list,get_post_detail])
        .mount("/user", routes![read, signup, login])
        // .register("/", catchers![not_found])
        // .attach(Template::fairing())
        .attach(cors)
        // .attach(JwtFairing)
        .launch()
        .await
        .map(|_| ())
}


pub fn main() {
    let result = start();

    println!("Rocket: Start ...");

    if let Some(err) = result.err() {
        println!("Error: {err}");
    }
}
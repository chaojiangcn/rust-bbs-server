#[macro_use]
extern crate rocket;

mod temp;
mod ums_user;
mod post_api;

use rocket::http::Method;
use sea_orm_rocket::Database;
use common::pool::Db;
use crate::temp::{create, delete, destroy, edit, list, update};
use crate::ums_user::read;
use crate::post_api::post_list;
use rocket_cors::{AllowedHeaders, AllowedOrigins};


#[rocket::main]
async fn start() -> Result<(), rocket::Error> {

    // let allowed_origins = AllowedOrigins::some_exact(&["https://www.acme.com"]);
    let allowed_origins = AllowedOrigins::all();
    // You can also deserialize this
    let cors = rocket_cors::CorsOptions {
        allowed_origins,
        allowed_methods: vec![Method::Get].into_iter().map(From::from).collect(),
        allowed_headers: AllowedHeaders::some(&["Authorization", "Accept"]),
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

    rocket::build()
        // 连接数据库
        .attach(Db::init())
        .mount("/post", routes![post_list])
        .mount(
            "/post_temp",
            routes![create, delete, destroy, list, edit, update],
        )
        .mount("/user", routes![read])
        // .register("/", catchers![not_found])
        // .attach(Template::fairing())
        .attach(cors)
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
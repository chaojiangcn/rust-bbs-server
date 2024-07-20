#[macro_use]
extern crate rocket;

mod ums_user;
mod post_api;
mod like_api;
mod favorite_api;
mod follow_api;
mod comment_api;

use rocket::http::Method;
use common::setup::set_up_db;
use crate::ums_user::{login, read, signup};
use crate::post_api::{add_post, get_post_detail, post_list};
use rocket_cors::{AllowedHeaders, AllowedOrigins};
use crate::comment_api::{add_comment, delete_comment, get_list_with_page};
use crate::favorite_api::{favorite, un_favorite};
use crate::like_api::{get_list_in_page, like, unlike};


#[rocket::main]
async fn start() -> Result<(), rocket::Error> {
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
        .manage(db)
        .mount("/post", routes![post_list, get_post_detail, add_post])
        .mount("/user", routes![read, signup, login])
        .mount("/like", routes![like, unlike, get_list_in_page])
        .mount("/favorite", routes![favorite, un_favorite])
        .mount("/follow", routes![follow_api::follow, follow_api::un_follow])
        .mount("/comment", routes![get_list_with_page, add_comment, delete_comment])
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
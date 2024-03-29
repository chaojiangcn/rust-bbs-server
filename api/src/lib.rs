#[macro_use]
extern crate rocket;

mod pool;
mod temp;

use rocket::tokio;
use sea_orm_rocket::Database;
use pool::Db;
use crate::temp::{create, delete, destroy, edit, list,  update};


#[rocket::main]
async fn start() -> Result<(), rocket::Error> {
    rocket::build()
        .attach(Db::init())
        .mount(
            "/post",
            routes![create, delete, destroy, list, edit, update],
        )
        // .register("/", catchers![not_found])
        // .attach(Template::fairing())
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
#[macro_use]
extern crate rocket;

// add our modules
mod services;
mod routes;
mod models;

// import our routes
use crate::routes::user::{date_plus_month, get_current_date};


#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/api", routes![get_current_date, date_plus_month])
}

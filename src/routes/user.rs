use rocket::serde::json::Json;
use crate::models::user::User;
use crate::services;

// create get-current-date route under /date and call get_current_date service which will return a Date object
// route returns a Date object converted to JSON
#[get("/date/get-current-date")]
pub fn get_current_date() -> Json<User> {
    Json(services::user::get_current_date())
}

// route will accept data in JSON format and expects a date variable in the function parameters
#[post("/date/date-plus-month", format = "json", data = "<date>")]
pub fn date_plus_month(date: Json<User>) -> Json<User> {
    Json(services::user::date_plus_month(date))
}
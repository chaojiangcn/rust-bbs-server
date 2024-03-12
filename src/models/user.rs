
use rocket::serde::{Serialize, Deserialize};

// create a struct to hold our Date data
// need serialize/deserialize to convert to/from JSON
#[derive(Debug, Deserialize, Serialize)]
#[serde(crate = "rocket::serde")]
pub struct User {
    pub day: u32,
    pub month: u32,
    pub year: i32
}
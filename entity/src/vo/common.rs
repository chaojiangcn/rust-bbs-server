use rocket::serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, Debug)]
pub struct PageRes<T>{
    pub list: Vec<T>,
    pub total: u64,
}
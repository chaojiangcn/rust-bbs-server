use rocket::serde::{Deserialize, Serialize};
use validator::Validate;

#[derive(Debug, Serialize, Deserialize, Validate)]
pub struct PageParams {
    #[validate(range(min = 1))]
    pub page: u64,
    pub size: u64,
    pub keyword: Option<String>
}
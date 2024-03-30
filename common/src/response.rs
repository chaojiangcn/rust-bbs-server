use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub struct Response<T> {
    pub code: i32,
    pub message: String,
    pub data:T,
}
pub  fn success<T>(data: T, message: &str) -> Response<T> {
    Response {
        code: 200,
        message: message.to_string(),
        data,
    }
}

pub fn  error<T>(code: i32, message: &str, data: T) -> Response<T> {
    Response {
        code,
        message: message.to_string(),
        data,
    }
}
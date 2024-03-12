#[macro_use]
extern crate rocket;

use rocket::tokio::time::{sleep, Duration};


#[get("/hello")]
fn index() -> &'static str {
    "Hello, world!"
}

#[get("/hi")]
fn world() -> &'static str {
    "Hi, world!"
}

#[get("/delay/<second>")]
async fn delay(second: u64) -> String {
    sleep(Duration::from_secs(second)).await;
    format!("Waited for {} seconds", second)
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![index])
        .mount("/hi", routes![world])
        .mount("/delay", routes![delay])
}

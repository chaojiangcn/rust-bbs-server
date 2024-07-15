use jsonwebtoken::{decode, DecodingKey, Validation};
use rocket::fairing::{Fairing, Info, Kind};
use rocket::{Data, Request};
use rocket::http::Status;
use rocket::request::{FromRequest, Outcome};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize,Serialize)]
pub struct Claims {
    pub sub: String,
    pub exp: usize,
}

pub struct Token {
    pub claims: Claims,
}

#[rocket::async_trait]
impl<'r> FromRequest<'r> for Token {
    type Error = ();


    async fn from_request(request: &'r Request<'_>) -> Outcome<Self, Self::Error> {
        let keys: Vec<_> = request.headers().get("Authorization").collect();
        if keys.len() != 1 {
            return Outcome::Error((Status::Unauthorized, ()));
        }

        let token = keys[0].replace("Bearer ", "");
        let key = DecodingKey::from_secret("rust_bbs".as_ref());
        let res = decode::<Claims>(&token, &key, &Validation::default());
        match res {
            Ok(token_data) => {
                Outcome::Success(Token {
                    claims: token_data.claims,
                })
            },
            Err(err) => {
                println!("decode token error: {:?}", err);
                Outcome::Error((Status::Unauthorized, ()))
            },
        }

    }
}

pub struct JwtFairing;

#[rocket::async_trait]
impl Fairing for JwtFairing {
    fn info(&self) -> Info {
        Info {
            name: "Jwt Auth Fairing",
            kind: Kind::Request,
        }
    }

    async fn on_request(&self, request: &mut Request<'_>, _data: &mut Data<'_>) {
        let white_list = vec!["/user/login", "/user/signup"];

        if white_list.contains(&request.uri().path().as_str()) {
            return;
        }

        let keys: Vec<_> = request.headers().get("Authorization").collect();
        if keys.len() != 1 {
            request.local_cache(|| false);
            request.local_cache(|| None::<Token>);
            return;
        }

        let token = keys[0].replace("Bearer ", "");
        let key = DecodingKey::from_secret("rust_bbs".as_ref());
        match decode::<Claims>(&token, &key, &Validation::default()) {
            Ok(token_data) => {
                request.local_cache(|| Some(Token {
                    claims: token_data.claims,
                }));
            }
            Err(_) => {
                request.local_cache(|| None::<Token>);
            }
        }
    }
}
use jsonwebtoken::errors::Error;
use rocket::Responder;
use sea_orm::DbErr;
use validator::ValidationErrors;

#[derive(Responder)]
#[response(status = 500, content_type = "json")]
pub struct ErrorResponder {
    message: String,
}

// The following impl's are for easy conversion of error types.
impl From<DbErr> for ErrorResponder {
    fn from(err: DbErr) -> ErrorResponder {
        ErrorResponder {
            message: err.to_string(),
        }
    }
}

impl From<String> for ErrorResponder {
    fn from(string: String) -> ErrorResponder {
        ErrorResponder { message: string }
    }
}

impl From<&str> for ErrorResponder {
    fn from(str: &str) -> ErrorResponder {
        str.to_owned().into()
    }
}

impl From<ValidationErrors> for ErrorResponder {
    fn from(value: ValidationErrors) -> Self {
        ErrorResponder {
            message: value.to_string(),
        }
    }
}

impl From<jsonwebtoken::errors::Error> for ErrorResponder {
    fn from(value: Error) -> Self {
        ErrorResponder {
            message: value.to_string(),
        }
    }
}


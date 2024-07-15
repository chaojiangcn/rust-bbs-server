use sea_orm::{DbConn, EntityTrait, PaginatorTrait, QueryOrder};
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use validator::Validate;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::{error, Response, success};
use entity::po::like;
use entity::vo::common::PageRes;


pub async fn get_list_in_page(db: &DbConn, req: PageParams) -> Result<Json<Response<Value>>, ErrorResponder> {
    // 参数验证
    if let Err(e) = req.validate() {
        let err_str = e.to_string();
        return Ok(Json(error(json!(""), &err_str)));
    }
    let pagination = like::Entity::find()
        .order_by_asc(like::Column::LikedAt)
        .paginate(db, req.size);
    let total = pagination.num_items().await.unwrap();
    let list = pagination.fetch_page(req.page - 1).await?;
    let mut resp = PageRes {
        list: vec![],
        total: 0,
    };

    if !list.is_empty() {
        resp.total = total;
        resp.list = list;
    }

    Ok(Json(success(json!(resp), "success")))
}

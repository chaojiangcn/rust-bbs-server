use chrono;
use common::custom_responder::ErrorResponder;
use common::request::PageParams;
use common::response::{error, success, Response};
use entity::po::like;
use entity::vo::common::PageRes;
use entity::vo::like::{AddLikeReq, AddUnLikeReq};
use sea_orm::{ColumnTrait, DbConn, EntityTrait, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm_rocket::rocket::serde::json::serde_json::json;
use sea_orm_rocket::rocket::serde::json::{Json, Value};
use validator::Validate;

pub struct LikeService;

impl LikeService {
    pub async fn get_list_in_page(
        db: &DbConn,
        req: PageParams,
    ) -> Result<Json<Response<Value>>, ErrorResponder> {
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

    pub async fn get_count(db: &DbConn, post_id: i32) -> u64 {
        let res = like::Entity::find()
            .filter(like::Column::PostId.eq(post_id))
            .count(db)
            .await;
        return if res.is_err() { 0 } else { res.unwrap() };
    }

    pub async fn like(
        db: &DbConn,
        param: Json<AddLikeReq>,
    ) -> Result<Json<Response<Value>>, ErrorResponder> {
        if let Err(e) = param.validate() {
            let err_str = e.to_string();
            return Ok(Json(error(json!(""), &err_str)));
        }
        let res = like::Entity::insert(like::ActiveModel {
            post_id: sea_orm::Set(param.post_id),
            user_id: sea_orm::Set(param.user_id),
            liked_at: sea_orm::Set(chrono::Utc::now().into()),
        });

        if let Err(err) = res.exec(db).await {
            return Err(ErrorResponder::from(err));
        }

        Ok(Json(success(json!({}), "success")))
    }

    pub async fn unlike(
        db: &DbConn,
        param: Json<AddUnLikeReq>,
    ) -> Result<Json<Response<Value>>, ErrorResponder> {
        let count = like::Entity::delete_many()
            .filter(like::Column::PostId.eq(param.post_id))
            .filter(like::Column::UserId.eq(param.user_id))
            .exec(db)
            .await?
            .rows_affected;
        if count == 0 {
            return Ok(Json(error(json!(""), "未找到该记录")));
        }
        Ok(Json(success(json!({}), "success")))
    }
}

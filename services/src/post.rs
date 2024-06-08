use sea_orm::{DbConn, DbErr, EntityTrait, PaginatorTrait, QueryOrder};
use common::request::PageParams;
use entity::{post};

pub struct PostService;


impl PostService {
    pub async fn get_list_in_page(db: &DbConn, req: PageParams) -> Result<(Vec<post::Model>, u64), DbErr> {
        let paginator = post::Entity::find()
            .order_by_asc(post::Column::Id)
            .paginate(db, req.size);

        let num_pages = paginator.num_pages().await?;

        paginator.fetch_page(req.page - 1).await.map(|p| (p, num_pages))
    }
}
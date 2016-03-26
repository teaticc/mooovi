class ProductsController < RankingController
  before_action :authenticate_user!, only: :search

  def index
    @products = Product.order('id ASC').limit(20)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
    @products = Product.where('title LIKE(?)',"%#{params[:keyword]}%").limit(20)
  end
end

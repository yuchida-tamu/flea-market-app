class ProductsController < ApplicationController
  before_action :require_user_logged_in, only:[:new, :edit, :create, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product =  current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = '商品を公開しました'
      redirect_to @product
    else
      flash.now[:danger] = "商品を登録できませんでした"
      redirect_to :new
    end

  end

  def edit
    @product = Product.find(params[:id])
    @product.picture.attach(params[:picture]) if(params[:picture])
     
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      flash[:success] = "商品内容を変更しました"
      redirect_to @product
    else
      flash[:danger] = "変更できませんでした"
      redirect_to root_url
    end
  end

  def destroy
    @product.destroy
    flash[:success] = '商品を削除しました。'
    redirect_to root_url
  end

  def product_params
    params.require(:product).permit(:name, :price, :info, :picture)
  end


  def correct_user
    @product = current_user.products.find_by(id: params[:id])
    unless @product 
      redirect_to root_url
    end
  end
end

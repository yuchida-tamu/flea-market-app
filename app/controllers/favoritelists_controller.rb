class FavoritelistsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    current_user.add_favorite(product)
    flash[:success] = 'お気に入りに登録しました'
    redirect_to product
  end

  def destroy
    product = Product.find(params[:product_id])
    current_user.remove_favorite(product)
    flash[:danger] = 'お気に入りから解除しました'
    redirect_to product
  end
end

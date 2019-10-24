class ToppagesController < ApplicationController
  def index
    @products = Product.order(id: :desc).page(params[:page])
  end
end

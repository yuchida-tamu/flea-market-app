class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy, :followings, :followers]
  before_action :correct_user, only: [ :edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products.order(id: :desc).page(params[:page])
    counts(@user)

    if current_user == @user
      @following_user_products = current_user.feed_following_user_products.order(id: :desc).page(params[:page])
    end

    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)

    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザー登録を完了しました'
      redirect_to @user
    else 
      flash.now[:danger] = 'ユーザーの登録に失敗しました'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.profile.attach(params[:profile]) if(params[:profile])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィールを編集しました'
      redirect_to @user
    else 
      flash.now[:danger] = 'プロフィールの編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = 'ユーザーを削除しました'
    redirect_to root_url
  end

  def followings 
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    if current_user == @user
      @following_user_products = current_user.feed_following_user_products.order(id: :desc).page(params[:page])
    end
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    if current_user == @user
      @following_user_products = current_user.feed_following_user_products.order(id: :desc).page(params[:page])
    end
    counts(@user)
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites.page(params[:page])
    if current_user == @user
      @following_user_products = current_user.feed_following_user_products.order(id: :desc).page(params[:page])
    end
    counts(@user)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
        redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
end

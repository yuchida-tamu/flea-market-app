class ApplicationController < ActionController::Base

    include SessionsHelper

    private

    def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
    end

    def require_tobe_the_right_user (user)
        unless current_user = user
            redirect_to root
        end
    end

    def counts(user)
        @count_products = user.products.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
        @count_favorites = user.favorites.count
      end
   
end

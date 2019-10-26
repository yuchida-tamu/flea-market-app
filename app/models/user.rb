class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false} 
    has_secure_password

    has_one_attached :profile

    has_many :products, dependent: :destroy
    has_many :favoritelists, dependent: :destroy
    has_many :favorites, through: :favoritelists, source: :product, dependent: :destroy

    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow, dependent: :destroy
    has_many :reverse_of_relationship, class_name: 'Relationship', foreign_key: "follow_id", dependent: :destroy
    has_many :followers, through: :reverse_of_relationship, source: :user, dependent: :destroy

    def add_favorite (product)
        self.favoritelists.find_or_create_by(product_id: product.id)
    end

    def remove_favorite (product)
        favorite = self.favoritelists.find_by(product_id: product.id)
        favorite.destroy if favorite
    end 

    def is_favorite? (product)
        self.favorites.include?(product)
    end

    def follow (other_user)
        unless  self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    def unfollow (other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end 

    def following? (other_user)
        self.followings.include?(other_user)
    end

    def feed_following_user_products
        Product.where(user_id: self.following_ids)
    end

end

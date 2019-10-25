class Product < ApplicationRecord
    belongs_to :user
    has_many :favoritelists

    validates :name, presence: true, length: { maximum: 50 }
    validates :price, presence: true, length: { maximum: 30}
    validates :info, presence: true, length: { maximum: 1000 }


end

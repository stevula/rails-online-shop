class Product < ActiveRecord::Base
  validates :name,:description,:quantity,:price, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :quantity, :price , greater_than_or_equal_to: 0
  has_and_belongs_to_many :shopping_carts
end

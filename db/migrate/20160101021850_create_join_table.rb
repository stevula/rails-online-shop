class CreateJoinTable < ActiveRecord::Migration
  def change
    create_table :products_shopping_carts do |t|
      t.belongs_to :product
      t.belongs_to :shopping_cart
    end
  end
end

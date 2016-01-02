class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end

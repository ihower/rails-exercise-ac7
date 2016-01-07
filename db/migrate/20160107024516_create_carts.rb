class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|

      t.timestamps null: false
    end

    add_column :line_items, :cart_id, :integer
    add_index :line_items, :cart_id

  end
end

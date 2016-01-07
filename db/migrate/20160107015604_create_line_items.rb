class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id, :null => false
      t.integer :order_id, :null => false, :index => true 
      t.integer :qty, :null => false
      t.timestamps null: false
    end
  end
end

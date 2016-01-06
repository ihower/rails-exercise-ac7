class CreateGroupships < ActiveRecord::Migration
  def change
    create_table :groupships do |t|
      t.integer :topic_id, :index => true
      t.integer :group_id, :index => true
      t.timestamps null: false
    end
  end
end

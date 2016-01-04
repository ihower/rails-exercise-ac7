class AddViewsCountToTopics < ActiveRecord::Migration

  def change
    add_column :topics, :views_count, :integer, :default => 0
  end

end

class AddPhotoToTopics < ActiveRecord::Migration

  def change
    add_attachment :topics, :photo
  end

end

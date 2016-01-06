class Groupship < ActiveRecord::Base

  belongs_to :topic
  belongs_to :group

end

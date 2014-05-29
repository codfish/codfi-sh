class UserUrl < ActiveRecord::Base
  attr_accessible :url_id, :user_id

  belongs_to :url
  belongs_to :user
end

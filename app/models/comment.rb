class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates :text, presence: true
end

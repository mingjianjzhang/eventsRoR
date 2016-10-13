class Event < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
  has_many :comments
  has_many :event_users, dependent: :destroy
  has_many :event_joiners, through: :event_users, source: :user
  validates :name, :state, :city, presence: true
  validate :date_in_future
  def self.with_owner(query=nil)
  	self.joins(:owner).select("events.id as events_id", :name, "strftime('%Y-%m-%d', date) as nice_date, events.city, events.state, owner_id as owner_id, users.first_name as owner_name").where("#{query}")
  end
  

  def date_in_future
 	if date.blank?
 		errors.add(:date, "can't be blank")
 	elsif date < Date.today
  		errors.add(:date, "Can't create events in the past")  
  	end
  end

end


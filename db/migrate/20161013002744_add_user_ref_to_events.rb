class AddUserRefToEvents < ActiveRecord::Migration
  def change
  	add_reference :events, :owner, references: :users, index: true
  	add_foreign_key :posts, :users, column: :owner_id
  end
end

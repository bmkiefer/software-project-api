class AddUserToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :user_id, :integer
    add_column :polls, :created, :datetime
  end
end

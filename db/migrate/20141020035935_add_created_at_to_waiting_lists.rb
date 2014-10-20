class AddCreatedAtToWaitingLists < ActiveRecord::Migration
  def change
    add_column :waiting_lists, :created_at, :datetime
  end
end

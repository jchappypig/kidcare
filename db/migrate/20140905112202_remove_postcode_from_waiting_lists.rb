class RemovePostcodeFromWaitingLists < ActiveRecord::Migration
  def change
    remove_column :waiting_lists, :postcode
  end
end

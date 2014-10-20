class ChangeDateContactedToDateInWaitingLists < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :waiting_lists do |t|
        dir.up do
          t.change :date_contacted, :date
        end
        dir.down { t.change :date_contacted, :datetime }
      end
    end
  end
end

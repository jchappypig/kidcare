class ChangeStartDateOfWaitingListToDate < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :waiting_lists do |t|
        dir.up do
          t.change :expect_join_time, 'date USING ("expect_join_time"::text::date)'
        end
        dir.down { t.change :expect_join_time, :string }
      end
    end
  end
end

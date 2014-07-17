class CreateWaitingLists < ActiveRecord::Migration
  def change
    create_table :waiting_lists do |t|
      t.string :child_name
      t.integer :child_age
      t.string :parent_name
      t.string :phone
      t.text :address
      t.string :postcode
      t.string :expect_join_time
      t.string :days_per_week

      t.timestamps
    end
  end
end

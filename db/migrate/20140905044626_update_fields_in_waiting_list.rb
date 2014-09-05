class UpdateFieldsInWaitingList < ActiveRecord::Migration
  def change
    change_table :waiting_lists do |t|
      t.rename :parent_name, :parent_full_name
      t.rename :child_name, :child_full_name
      t.rename :phone, :home_phone
      t.rename :expect_join_time, :intend_start_date
      t.rename :days_per_week, :days_required
      t.rename :created_at, :date_contacted
    end

    add_column :waiting_lists, :mobile_phone, :string
    add_column :waiting_lists, :child_dob, :date
    add_column :waiting_lists, :preferred_way_of_contact, :string
    remove_column :waiting_lists, :child_age
  end
end

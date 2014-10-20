class CreateGroupTimePlanning < ActiveRecord::Migration
  def change
    create_table :group_time_plannings do |t|
      t.text :morning
      t.text :late_morning
      t.text :afternoon
      t.text :late_afternoon
      t.text :finishing_up
      t.string :day
      t.references :weekly_program
    end
  end
end

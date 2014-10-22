class AddPublishedToWeeklyProgram < ActiveRecord::Migration
  def change
    add_column :weekly_programs, :published, :boolean, default: false
  end
end

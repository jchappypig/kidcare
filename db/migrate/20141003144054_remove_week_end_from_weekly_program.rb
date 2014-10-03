class RemoveWeekEndFromWeeklyProgram < ActiveRecord::Migration
  def change
    remove_column :weekly_programs, :week_end, :date
  end
end

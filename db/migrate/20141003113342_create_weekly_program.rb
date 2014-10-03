class CreateWeeklyProgram < ActiveRecord::Migration
  def change
    create_table :weekly_programs do |t|
      t.date :week_start
      t.date :week_end
      t.string :program_staff
      t.string :theme
      t.string :goals
      t.string :letter
      t.string :number
      t.string :colour
      t.string :shape
    end
  end
end

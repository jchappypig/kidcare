class ChangeNumberInWeeklyProgramToInteger < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :weekly_programs do |t|
        dir.up do
          t.change :number, 'integer USING (trim(number)::integer);'
        end
        dir.down { t.change :number, :string }
      end
    end
  end
end

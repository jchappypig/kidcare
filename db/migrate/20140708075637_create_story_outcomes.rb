class CreateStoryOutcomes < ActiveRecord::Migration
  def change
    create_table :story_outcomes do |t|
      t.belongs_to :story
      t.belongs_to :outcome
    end
  end
end

class CreateActivity < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :category
      t.string :day
      t.text :cross_mentor
      t.string :cross_mentor_outcome
      t.text :social
      t.string :social_outcome
      t.text :art_and_craft
      t.string :art_and_craft_outcome
      t.text :language
      t.string :language_outcome
      t.references :weekly_program
    end
  end
end

class AddCognitiveAndCognitiveOutcomesToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :cognitive, :text
    add_column :activities, :cognitive_outcome, :string
  end
end

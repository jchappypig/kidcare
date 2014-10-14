class AddCognitiveAndCognitiveOutcomesToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :cognitive, :string
    add_column :activities, :cognitive_outcome, :string
  end
end

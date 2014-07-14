class RemoveTitleFromStory < ActiveRecord::Migration
  def change
    remove_column :stories, :title
  end
end

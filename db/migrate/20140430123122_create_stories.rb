class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :name
      t.string :image
      t.text :description
      t.integer :status
      t.integer :is_enabled

      t.timestamps
    end
  end
end

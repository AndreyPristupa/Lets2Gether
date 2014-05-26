class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :start_at
      t.integer :end_at
      t.decimal :cost
      t.attachment :image
      t.string :video
      t.integer :views
      t.integer :is_enabled
      t.integer :status

      t.timestamps
    end
  end
end

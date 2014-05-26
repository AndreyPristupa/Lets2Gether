class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.integer :status_id

      t.timestamps
    end
  end
end

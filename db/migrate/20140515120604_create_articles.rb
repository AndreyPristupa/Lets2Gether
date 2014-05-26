class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.text :description
      t.integer :status_id
      t.integer :group_id

      t.timestamps
    end
  end
end

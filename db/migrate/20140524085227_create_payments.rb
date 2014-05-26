class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :payment_system_id
      t.integer :amount
      t.string :currency
      t.integer :status_id

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customer
      t.string :order_number
      t.string :despatch_date
      t.string :status
      t.text :comments

      t.timestamps
    end
  end
end

class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.string :carrier
      t.string :packaging_details
      t.string :shipping_data_url
      t.string :shipping_date
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end

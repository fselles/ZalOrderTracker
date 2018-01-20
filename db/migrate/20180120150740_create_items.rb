class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :article_number
      t.string :article_description
      t.string :quantity
      t.string :hrpdf_url
      t.string :item_comments
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end

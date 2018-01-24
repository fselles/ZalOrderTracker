class ChangeItemArticleDescription < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :article_description, :text
  end
end

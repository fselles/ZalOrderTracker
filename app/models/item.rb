class Item < ApplicationRecord
  belongs_to :order

  def self.search(search)
    where("article_description LIKE ?", "%#{search}%")
  end

end

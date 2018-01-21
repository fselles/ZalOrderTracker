class Order < ApplicationRecord
  has_many :shippings, dependent: :destroy
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :shippings

  def self.search(search)
    joins(:items)
    .where("order_number LIKE ? OR despatch_date LIKE ? OR status LIKE ? OR items.article_description LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end


end

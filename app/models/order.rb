class Order < ApplicationRecord
  has_many :shippings, dependent: :destroy
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :shippings

  def self.search(search)
    where("order_number LIKE ? OR despatch_date LIKE ? OR status LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end


end

class Order < ApplicationRecord
  ORDERSTATUS= ['', 'new', 'prepress', 'print', 'nabewerking', 'verpakken']
  has_many :shippings, dependent: :destroy
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :shippings
  scope :active, -> { where("status NOT IN (?)", "gereed") }
  scope :archive, -> { where(status: "gereed") }

  def self.search(search)
    joins(:items, :shippings)
    .where("order_number LIKE ? OR despatch_date LIKE ? OR status LIKE ? OR items.article_description LIKE ? OR shippings.carrier LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.status(status)
    where("status LIKE ? ", "%#{status}%")
  end


end

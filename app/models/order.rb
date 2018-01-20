class Order < ApplicationRecord
  has_many :shippings, dependent: :destroy
  has_many :items, dependent: :destroy
end

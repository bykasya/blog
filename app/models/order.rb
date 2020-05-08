class Order < ApplicationRecord
  belongs_to :customer

  validates :product_name, presence: true
  validates :product_count, presence: true
  validates :product_count, numericality: { only_integer: true, greater_than: 0 }
  validates :customer_id, presence: true
  validates_presence_of :customer
end

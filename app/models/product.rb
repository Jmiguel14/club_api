class Product < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :invoices, through: :invoice_details

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

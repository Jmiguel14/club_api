class Invoice < ApplicationRecord
  belongs_to :apartment
  has_many :invoice_details, dependent: :destroy
  has_many :products, through: :invoice_details

  enum :status, { draft: 0, issued: 1, paid: 2, canceled: 3 }, default: :draft

  accepts_nested_attributes_for :invoice_details, allow_destroy: true

  validates :issued_on, presence: true
end

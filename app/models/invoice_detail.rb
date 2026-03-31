class InvoiceDetail < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :invoice
  belongs_to :product, optional: true

  enum :type, { product: "product", point: "point" }, default: :product, validate: true

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, presence: true, if: :product?
  validates :product_id, uniqueness: { scope: :invoice_id }, if: :product?
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :product?
  validates :point_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :point?
  validates :label, presence: true, length: { maximum: 255 }, if: :point?

  before_validation :assign_default_unit_price, on: :create
  before_validation :coerce_fields_for_line_kind

  # Positive magnitude (qty × price or qty × points).
  def line_magnitude
    quantity * (product? ? unit_price : point_cost)
  end

  # Net effect on invoice balance: club pays services (+), bar consumption (−).
  def line_total
    product? ? -line_magnitude : line_magnitude
  end

  private

  def assign_default_unit_price
    self.unit_price ||= product&.price if product?
  end

  def coerce_fields_for_line_kind
    if point?
      self.product_id = nil
      self.unit_price = nil
    else
      self.point_cost = nil
      self.label = nil
    end
  end
end

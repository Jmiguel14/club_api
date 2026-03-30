class CreateInvoiceDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_details do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :point_cost, precision: 10, scale: 2
      t.string :type, null: false, default: "product"

      t.timestamps
    end

    add_index :invoice_details, [ :invoice_id, :product_id ], unique: true
    add_check_constraint :invoice_details, "quantity > 0", name: "invoice_details_quantity_positive"
    add_check_constraint :invoice_details, "unit_price >= 0", name: "invoice_details_unit_price_non_negative"
    add_check_constraint :invoice_details, "point_cost >= 0", name: "invoice_details_point_cost_non_negative"
    add_check_constraint :invoice_details, "type IN ('product', 'point')", name: "invoice_details_type_valid"
  end
end

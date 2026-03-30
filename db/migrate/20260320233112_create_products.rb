class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :sku, null: false
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0
      t.integer :stock, null: false, default: 0

      t.timestamps
    end

    add_index :products, :sku, unique: true
    add_check_constraint :products, "price >= 0", name: "products_price_non_negative"
    add_check_constraint :products, "stock >= 0", name: "products_stock_non_negative"
  end
end

class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :apartment, null: false, foreign_key: true
      t.date :issued_on, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

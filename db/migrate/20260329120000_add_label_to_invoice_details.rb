# frozen_string_literal: true

class AddLabelToInvoiceDetails < ActiveRecord::Migration[8.0]
  def change
    add_column :invoice_details, :label, :string
  end
end

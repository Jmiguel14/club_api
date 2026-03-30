class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show update destroy ]

  def index
    invoices = Invoice.includes(:apartment).order(created_at: :desc)
    render json: invoices, include: [ :apartment, invoice_details: { include: :product } ]
  end

  def show
    render json: @invoice, include: [ :apartment, invoice_details: { include: :product } ]
  end

  def create
    invoice = Invoice.new(invoice_params)

    if invoice.save
      render_invoice(invoice, status: :created)
    else
      render_validation_errors(invoice)
    end
  end

  def update
    if @invoice.update(invoice_params)
      render_invoice(@invoice.reload)
    else
      render_validation_errors(@invoice)
    end
  end

  def destroy
    @invoice.destroy!
    head :no_content
  end

  private

  def set_invoice
    @invoice = Invoice.includes(:apartment, invoice_details: :product).find(params.expect(:id))
  end

  def invoice_params
    params.require(:invoice).permit(
      :apartment_id,
      :issued_on,
      :status,
      invoice_details_attributes: %i[
        id
        type
        product_id
        quantity
        unit_price
        point_cost
        label
        _destroy
      ]
    )
  end

  def render_invoice(invoice, status: :ok)
    invoice = Invoice.includes(:apartment, invoice_details: :product).find(invoice.id)
    render json: invoice,
           status: status,
           include: [ :apartment, { invoice_details: { include: :product } } ]
  end
end

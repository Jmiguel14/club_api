class InvoiceDetailsController < ApplicationController
  before_action :set_invoice_detail, only: %i[ show update destroy ]

  def index
    invoice_details = InvoiceDetail.includes(:invoice, :product).order(created_at: :desc)
    render json: invoice_details, include: [ :invoice, :product ]
  end

  def show
    render json: @invoice_detail, include: [ :invoice, :product ]
  end

  def create
    invoice_detail = InvoiceDetail.new(invoice_detail_params)

    if invoice_detail.save
      render json: invoice_detail, status: :created, location: invoice_detail
    else
      render_validation_errors(invoice_detail)
    end
  end

  def update
    if @invoice_detail.update(invoice_detail_params)
      render json: @invoice_detail
    else
      render_validation_errors(@invoice_detail)
    end
  end

  def destroy
    @invoice_detail.destroy!
    head :no_content
  end

  private

  def set_invoice_detail
    @invoice_detail = InvoiceDetail.includes(:invoice, :product).find(params.expect(:id))
  end

  def invoice_detail_params
    params.expect(invoice_detail: [ :invoice_id, :product_id, :quantity, :unit_price, :point_cost, :type, :label ])
  end
end

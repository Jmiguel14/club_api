require "test_helper"

class InvoiceDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice_detail = invoice_details(:one)
  end

  test "should get index" do
    get invoice_details_url, as: :json
    assert_response :success
  end

  test "should create invoice_detail" do
    assert_difference("InvoiceDetail.count") do
      post invoice_details_url, params: { invoice_detail: { invoice_id: invoices(:one).id, product_id: products(:two).id, quantity: 2, unit_price: 10.0, point_cost: 0, type: "product" } }, as: :json
    end

    assert_response :created
  end

  test "should show invoice_detail" do
    get invoice_detail_url(@invoice_detail), as: :json
    assert_response :success
  end

  test "should update invoice_detail" do
    patch invoice_detail_url(@invoice_detail), params: { invoice_detail: { invoice_id: @invoice_detail.invoice_id, product_id: @invoice_detail.product_id, quantity: @invoice_detail.quantity, unit_price: @invoice_detail.unit_price, point_cost: @invoice_detail.point_cost, type: @invoice_detail.type } }, as: :json
    assert_response :success
  end

  test "should destroy invoice_detail" do
    assert_difference("InvoiceDetail.count", -1) do
      delete invoice_detail_url(@invoice_detail), as: :json
    end

    assert_response :no_content
  end
end

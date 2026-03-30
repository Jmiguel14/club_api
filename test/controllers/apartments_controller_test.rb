require "test_helper"

class ApartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @apartment = apartments(:one)
  end

  test "should get index" do
    get apartments_url, as: :json
    assert_response :success
  end

  test "should create apartment" do
    assert_difference("Apartment.count") do
      post apartments_url, params: { apartment: { email: "new_apartment@example.com", name: "New Apartment", phone: "3333333333" } }, as: :json
    end

    assert_response :created
  end

  test "should show apartment" do
    get apartment_url(@apartment), as: :json
    assert_response :success
  end

  test "should update apartment" do
    patch apartment_url(@apartment), params: { apartment: { email: @apartment.email, name: @apartment.name, phone: @apartment.phone } }, as: :json
    assert_response :success
  end

  test "should destroy apartment" do
    assert_difference("Apartment.count", -1) do
      delete apartment_url(@apartment), as: :json
    end

    assert_response :no_content
  end
end

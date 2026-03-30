class Users::SessionsController < Devise::SessionsController
  include DeviseApiSessionSkip

  respond_to :json
  before_action :authenticate_user!, only: :show

  def show
    render json: { user: user_payload(current_user) }, status: :ok
  end

  private

  def respond_with(resource, _opts = {})
    render json: { message: "Logged in successfully.", user: user_payload(resource) }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: "Logged out successfully." }, status: :ok
  end

  def user_payload(user)
    {
      id: user.id,
      email: user.email
    }
  end
end

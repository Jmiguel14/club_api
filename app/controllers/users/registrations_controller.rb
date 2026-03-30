class Users::RegistrationsController < Devise::RegistrationsController
  include DeviseApiSessionSkip

  respond_to :json

  protected

  def build_resource(hash = {})
    self.resource = resource_class.new(hash)
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: "Signed up successfully.", user: user_payload(resource) }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.expect(user: [ :email, :password, :password_confirmation ])
  end

  def user_payload(user)
    {
      id: user.id,
      email: user.email
    }
  end
end

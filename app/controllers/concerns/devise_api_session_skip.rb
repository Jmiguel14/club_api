# api_only Rails apps have no session store. Devise's SignInOut still runs
# expire_data_after_sign_in! on sign_in, which touches session — override to no-op.
module DeviseApiSessionSkip
  extend ActiveSupport::Concern

  private

  def expire_data_after_sign_in!
  end

  def expire_data_after_sign_out!
  end
end

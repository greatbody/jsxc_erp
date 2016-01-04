RailsAdmin.config do |config|
  config.authenticate_with do
    # warden.authenticate! scope: :user
    config.authorize_with :cancan, AdminAbility
  end
  config.current_user_method(&:current_user)
end

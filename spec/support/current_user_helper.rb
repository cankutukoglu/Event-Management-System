module CurrentUserHelper
  def sign_in_as_admin
    admin = FactoryBot.create(:user, user_type: :admin)
    Rails.application.env_config["rack.session"] ||= {}
    Rails.application.env_confg["rack.session"]["user_id"] = admin.id
    admin
  end
end

RSpec.configure { |c| c.include CurrentUserHelper }

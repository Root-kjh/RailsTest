class  Api::V1::UserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token, raise: false
    
  require './lib/controllers/users/user_data_to_json'

  def create
    user = User.find_by email: auth_params[:email]
    render(json: user_data_to_json(user, auth_token.token))
  end
end

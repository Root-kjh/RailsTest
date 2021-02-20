class Api::V1::UsersController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    require './lib/controllers/users/user_data_to_json'

    def signup
        user = User.create!(signup_params)
        if user.save
            render(json: user_data_to_json(user, get_token(user['id'])), status: :created)
        else
            render(json: user.errors, status: :bad_request)
        end
    end
    
    private

    def signup_params
        params.permit(:firstName, :lastName, :email, :password, :country)
    end

    def get_token(user_id)
        return Knock::AuthToken.new(payload: {sub: user_id}).token
    end
end

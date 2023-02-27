module Api
  module V1
    class SessionsController < ApplicationController
      def signup
        user = User.new(email: params[:email], password: params[:password])

        # if user is saved
        if user.save
          # we encrypt user info using the pre-define methods in application controller
          token = encode_user_data({ user_id: user.id })

          render json: { token: token }
        else
          render_errors(user.errors, status = :unprocessable_entity)
        end
      end

      def login
        user = User.find_by(email: params[:email])

        # you can use bcrypt to password authentication
        if user && user.password == params[:password]

          # we encrypt user info using the pre-define methods in application controller
          token = encode_user_data({ user_id: user.id })

          render json: { token: token }
        else
          render json: { message: "invalid credentials" }
        end
      end
    end
  end
end

class ApplicationController < ActionController::Base
  SECRET = "verylongsecrethardtoguess" # << Should be stored in ENV var or more secure place

  skip_before_action :verify_authenticity_token

  def render_422(errors = 'could not save data')
    render_errors(errors, 422)
  end

  def render_errors(errors, status = 400)
    data = {
      status: 'failed',
      message: Array.wrap(errors),
    }

    render json: data, status: status
  end

  def authentication
    # making a request to a secure route, token must be included in the headers
    decode_data = decode_user_data(request.headers["token"])
    # getting user id from a nested JSON in an array.
    user_id = decode_data[0]["user_id"] unless !decode_data
    # find a user in the database to be sure token is for a real user
    user = User.find_by(id: user_id)

    # The barebone of this is to return true or false, as a middleware
    # its main purpose is to grant access or return an error to the user

    if user
      return true
    else
      render json: { message: "invalid credentials" }
    end
  end

  # turn user data (payload) to an encrypted string  [ A ]
  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

  # decode token and return user info, this returns an array, [payload and algorithms]
  def decode_user_data(token)
    begin
      JWT.decode token, SECRET, true, { algorithm: "HS256" }
    rescue => e
      puts e
    end
  end
end

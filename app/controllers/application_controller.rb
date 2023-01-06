class ApplicationController < ActionController::Base
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
end

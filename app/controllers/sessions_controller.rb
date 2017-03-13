class SessionsController < Devise::SessionsController

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    return invalid_login_attempt unless resource
    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      return render nothing: true
    end
    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: flash[:alert], status: 401
  end


end
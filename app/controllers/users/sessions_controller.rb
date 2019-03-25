# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json, :js
  # before_action :configure_sign_in_params, only: [:create]
  # after_action :set_csrf_headers, only: :create

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    puts "here"
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      puts "in jhhhhhhhhhhere"
      sign_in :user, resource
      respond_to do |format|
        puts format
        format.html { return redirect_to root_url }
        format.json { render json: true, status: 201 }
      end
      # return render json: true, status: 201
    end

    invalid_login_attempt
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: flash[:alert], status: 401
  end

  # def set_csrf_headers
  #   if request.xhr?
  #     # Add the newly created csrf token to the page headers
  #     # These values are sent on 1 request only
  #     response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
  #     response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
  #   end
  # end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

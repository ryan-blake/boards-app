class OmniauthCallbacksController < ApplicationController


  def stripe_connect
    if current_user
    current_user.update_attributes({
      provider: request.env["omniauth.auth"].provider,
      uid: request.env["omniauth.auth"].uid,
      access_code: request.env["omniauth.auth"].credentials.token,
      publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
    })
      # anything else you need to do in response..
      @user = current_user
      sign_in_and_redirect @user, :event => :authentication
      flash[:notice] = "Signed in with #{current_user.provider.to_s.titleize} successfully."
    else
      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def facebook
        @user = UserProvider.find_for_facebook_oauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to root_path
        end
    end
end

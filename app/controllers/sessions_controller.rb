class SessionsController < Devise::SessionsController
  respond_to :html, :js
  def new
    self.resource = resource_class.new(sign_in_params)
    respond_to do |format|
      format.js
    end
  end
  respond_to :json

def create
    @resource = User.find_for_database_authentication(email: params[:user][:email])

    if @resource.present?
    if @resource.valid_password?(params[:user][:password])
      respond_to do |format|
        format.js  { flash[:notice] = "Welcome"}
      end
    else
      respond_to do |format|
         format.js { flash[:partial] = "Invalid Email or Password"
                     render action: 'password.js.erb'
                   }
      end
    end
    else
      respond_to do |format|
         format.js { flash[:partial] = "Invalid Email or Password"
                     render action: 'password.js.erb'
                   }
      end
    end

end

protected

def invalid_login_attempt
  set_flash_message(:notice, :invalid)
  render json: flash[:notice], status: 401
end
end

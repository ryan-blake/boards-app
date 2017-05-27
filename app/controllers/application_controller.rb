class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def price_param(items)
    if params[:max][0].to_i <= 0 && params[:min][0].to_i >= 1
      items  = items.min_price(params[:min][0].to_i).max_price(9999)
    elsif params[:min][0].to_i <= 0 && params[:max][0].to_i >= 1
      items  = items.min_price(1).max_price(params[:max][0].to_i)
    else
      items  = items.min_price(1).max_price(9999)
    end
  end

  def length_param(items)
    if params[:maximum][0].to_i <= 0 && params[:minimum][0].to_i >= 1
      items  = items.min_length_search(params[:minimum][0].to_i).max_length_search(9999)
    elsif params[:minimum][0].to_i <= 0 && params[:maximum][0].to_i >= 1
      items  = items.min_length_search(1).max_length_search(params[:maximum][0].to_i)
    else
      items  = items.min_length_search(1).max_length_search(9999)
    end
  end
protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :name, :address, :city, :state, :zipcode, :company, :tokens) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit({ roles: [] }, :email, :password, :current_password, :password_confirmation, :name, :address, :city, :state, :zipcode, :company, :tokens) }
  end

end

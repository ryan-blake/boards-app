class RegistrationsController < Devise::SessionsController
  respond_to :html, :js
  def new
    self.resource = resource_class.new(sign_in_params)
    respond_to do |format|
      format.js
    end
  end
end

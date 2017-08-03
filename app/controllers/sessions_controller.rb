class SessionsController < ApplicationController
  respond_to :html, :js
  def new
      respond_to do |format|
      format.js
    end
  end
end

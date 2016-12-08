module ApplicationHelper


private

  def signed_on
    @user == current_user
  end
  
end

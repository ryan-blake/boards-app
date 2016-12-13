module ApplicationHelper
  @types_search = Type.all
  @distances_search = Distance.all

private

  def signed_on
    @user == current_user
  end

end

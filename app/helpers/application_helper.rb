module ApplicationHelper
  @types_search = Type.all
  @distances_search = Distance.all



private

def sortable(column, title = nil)
  title ||= column.titleize
  direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
  link_to title, params.merge(:sort => column, :direction => direction, :page => nil).permit!


end

  def signed_on
    @user == current_user
  end

end

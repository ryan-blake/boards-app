module ApplicationHelper
  @types_search = Type.all
  @distances_search = Distance.all

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

private

  def signed_on
    @user == current_user
  end

end

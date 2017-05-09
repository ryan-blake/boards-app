class DelistMonthOldBoardsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    a = []
    boards = Board.where(:for_sale => true).group_by_day(:list_time, range: 20.days.ago.midnight..30.days.ago.midnight)
    boards.each do |i|
      i.for_sale = false
      i.list_time = ""
      i.save
    end

  end
end

class DelistMonthOldBoardsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    a = []
    boards = Board.where(:for_sale => true).group_by_day(:list_time, range: 3.weeks.ago.midnight..Time.now)
    boards.each do |i|
      i.for_sale = false
      i.list_time = ""
      i.save
    end

  end
end

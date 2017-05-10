class DelistMonthOldBoardsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    a = []
    boards = Board.where("list_time < ?", 20.days.ago).where(:for_sale => true)
    boards.each do |i|
      i.for_sale = false
      i.list_time = ""
      i.save
    end

  end
end

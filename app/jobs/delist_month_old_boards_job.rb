class DelistMonthOldBoardsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    a = []
    boards = Board.where(:for_sale => true)
    boards = boards.where(['list_time < ?', 10.days.ago])
    boards.each do |i|
      i.for_sale = false
      i.list_time = " "
      i.save
    end

  end
end

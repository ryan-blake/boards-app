class DelistMonthOldBoardsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    a = []
    boards = Board.where(:for_sale => false)
    boards.each do |i|
      i.for_sale = true
      i.list_time = [Time.now, Time.now - 2.weeks, Time.now - 4.weeks].sample
      i.save
    end

  end
end

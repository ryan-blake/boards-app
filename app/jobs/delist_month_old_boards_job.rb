class DelistMonthOldBoardsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    a = []
    boards = Board.where(:for_sale => true)
    boards = boards.where(['list_time < ?', 30.days.ago])
    boards.each do |i|
      i.for_sale = false
      i.list_time = " "
      i.save
    end
  end
  def perform(*args)
    a = []
    convos = Conversation.where(['created_at < ?', 15.days.ago])
    convos.each do |i|
      adminR = User.where(id: i.recipient_id).role
      adminS = User.where(id: i.sender_id).role
      unless ( adminR == "admin" || adminS == "admin" )
       i.destroy
      end
    end
  end
end

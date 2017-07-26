class BoardMailer < ApplicationMailer
  default from: "alerts@kuivir.com"

   def new_board(board)
     @board = board
     mail to: @board.user.email, subject: "New board posted.. #{board.title}"
   end


end

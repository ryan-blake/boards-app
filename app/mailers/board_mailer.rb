class BoardMailer < ApplicationMailer
  default from: "stillshreds@stillshreds.com"

   def new_board(board)
     @board = board

     mail to: @board.user.email, subject: "New board posted.. #{board.title}"


   end
end

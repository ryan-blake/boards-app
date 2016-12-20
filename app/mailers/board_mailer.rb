class BoardMailer < ApplicationMailer
  default from: "stillshreds@stillshreds.com"

   def new_board(board)
     @board = board

     mail to: @board.user.email, subject: "New board posted.. #{board.title}"
   end

   def tracking_number(board)
     @board = board
     a = @board.customer_id
     @customer = User.where(id: a).first
     mail to: @customer.email, subject: "Tracking number .. #{board.title}"
   end

end

class BoardMailer < ApplicationMailer
  default from: "youremail.com"

   def new_buyer(user, board)


     headers["Message-ID"] = "<comments/#{board.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{user.id}@your-app-name.example>"
     headers["References"] = "<post/#{board.id}@your-app-name.example>"

     @user = user
     @board = board
    #  @comment = comment


     mail(to: user.email, subject: "New interest on #{board.name}")
   end
end

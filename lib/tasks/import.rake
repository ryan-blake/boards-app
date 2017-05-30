
namespace :import do
  desc "Import boards from user csv"
  task.boards: :environment do
    # cloudflare/user/r339krmafas.csv
    filename = File.join Rails.root, "boards.csv"
    counter = 0

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      board = Board.new(title: row[:title], price: row[:price], cost: row[:cost], user: User.where(:email => row[:email]))
        if board.save
          counter += 1
        else
          puts "#{email} - #{board.errors.full_messages.join(",")}"
        end
    end
    puts "imported #{counter} users"
   end
end

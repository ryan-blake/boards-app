# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
type_array = %w{Surf Snow Skate}

type_array.each do |t|
  Type.find_or_create_by(
  name: t
  )
end

types = Type.all


User.create(
 name: "ryan",
 email: "ryan_blake@mac.com",
 role: 1,
 publishable_key: ENV['PUBLISHABLE_KEY'],
 provider: ENV['PROVIDER'],
 uid: ENV['UID'],
 access_code: ENV['ACCESS_CODE'],
 password: "testtest"
 )
 User.create(
 name: "ar",
 email: "r@mac.com",
 role: 0,
 password: "testtest"

)

users = User.all

10.times do
  Board.create!(
  title:       Faker::Hipster.word,
  description: Faker::Hipster.paragraph,
  length: Faker::Number.number(1),
  width: Faker::Number.number(1),
  volume: Faker::Number.number(1),
  type: types.sample,
  footgear: [true, false].sample,
  arrived: [true, false].sample,
  price: rand(10..40),
  user_id: User.all.sample.id

  )
end


boards = Board.all

puts "#{Board.count} boards"
puts"#{User.count} users"
puts"#{Type.count} types"

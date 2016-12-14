# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
type_array = %w{Surf Snow Skate Wake}

type_array.each do |t|
  Type.find_or_create_by(
  name: t
  )
end

types = Type.all

category_array = %w{Longboard(surf) SUP Skis(snow) Cruiser(skate) Skis(water)}

category_array.each do |t|
  Category.find_or_create_by(
  name: t
  )
end

categories = Category.all


User.create(
 name: "ryan",
 email: "ryan_blake@mac.com",
 role: 1,
 publishable_key: ENV['PUBLISHABLE_KEY'],
 provider: ENV['PROVIDER'],
 uid: ENV['UID'],
 access_code: ENV['ACCESS_CODE'],
 password: "testtest",
 address: "123 test st",
 city: "omaha",
 state: ["tx", "ca"].sample,
 zipcode: [76210, 90277, 76262, 76135].sample

 )
 User.create(
 name: "ar",
 email: "ryan_blake@me.com",
 role: 0,
 password: "testtest",
 address: "123 test st",
 city: "omaha",
 state: ["tx", "ca"].sample,
 zipcode: [76210, 90277, 76262, 76135].sample
)

users = User.all

20.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  description: Faker::Hipster.paragraph,
  length: Faker::Number.number(1),
  width: Faker::Number.number(1),
  volume: Faker::Number.number(1),
  type: types.sample,
  category: categories.sample,
  footgear: [true, false].sample,
  arrived: [true, false].sample,
  price: rand(10..40),
  user_id: User.all.sample.id,
  pending: [nil, true, false].sample,
  zipcode: [76210, 90277, 76262, 76135].sample
  )

  boards = Board.all

end

10.times do
  Image.create!(
  file_id: ['2f94b80570baba87f3647a4fb71ebb40523f6df0ac3cae7abad2dd8d3b97','538fe895b2b2842d90b5091e63b6a53196ca42e99841489562bc50895180'].sample,
  board_id: Board.all.sample.id
  )
end

images = Image.all

distance_array = %w(10 20 30 50 100 150 200 350 400)
distance_array.each do |c|
  Distance.find_or_create_by(
    value: c,
  board_id: [1..20].sample
    )
end
distances = Distance.all
puts "#{Image.count} images"
puts "#{Board.count} boards"
puts"#{User.count} users"
puts"#{Type.count} types"

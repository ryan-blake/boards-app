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
 # Type.find_by(name: "Surf").id

types = Type.all

# category_array = %w{Longboard(surf) SUP Short Skis Cruiser(skate) Skis(water)}
#
# category_array.each do |t|
#   Category.find_or_create_by(
#   name: t,
#   type_id: [1..4].sample
#   )
# end

Category.create(
  name: "Shortboard",
  type_id: Type.find_by(name: "Surf").id
)
Category.create(
  name: "Longboard",
  type_id: Type.find_by(name: "Surf").id
)
Category.create(
  name: "Stand Up Paddle",
  type_id: Type.find_by(name: "Surf").id
)
Category.create(
  name: "Snowboard",
  type_id: Type.find_by(name: "Snow").id
)
Category.create(
  name: "Skis",
  type_id: Type.find_by(name: "Snow").id
)
Category.create(
  name: "Wakeboard",
  type_id: Type.find_by(name: "Wake").id
)
Category.create(
  name: "Skis",
  type_id: Type.find_by(name: "Wake").id
)
Category.create(
  name: "Skateboard",
  type_id: Type.find_by(name: "Skate").id
)
Category.create(
  name: "Cruiser",
  type_id: Type.find_by(name: "Skate").id
)

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
 city: "roanoke",
 state: ["tx", "tx"].sample,
 zipcode: 76262

 )
 User.create(
 name: "ar",
 email: "ryan_blake@me.com",
 role: 0,
 password: "testtest",
 address: "123 test st",
 city: "denton",
 state: ["tx", "tx"].sample,
 zipcode: 76210

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
  price: rand(10..40),
  user_id: User.all.sample.id,
  pending: false,
  arrived: false,
  zipcode: [76210, 90277, 76262, 76135].sample,
  for_sale: true
  )
end
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
  price: rand(10..40),
  user_id: User.all.sample.id,
  pending: true,
  arrived: [true, false].sample,
  zipcode: [76210, 90277, 76262, 76135].sample,
  for_sale: false
  )

  boards = Board.all

end

25.times do
  Image.create!(
  file_id: ['b48e94cb5e3f89fde42820ba7d0840653cb999b65ba3c16e9a8f4ee835b1','c5fc067f1e1df54fbb415f5f8e4ae7e2d2a79d5836c9e4cd86336b769dad','0ef76e914d27cf9fe915155db07a3985fd8ab268bfd6de45e62f841437d0'].sample,
  board_id: Board.all.sample.id
  )
end

images = Image.all

distance_array = %w(10 20 30 50 100 150 200 350 400)

distance_array.each do |c|
  Distance.create!(
    value: c,
  board_id: Board.all.sample.id
    )
end

distances = Distance.all
puts "#{Distance.count} distance"
puts "#{Image.count} images"
puts "#{Board.count} boards"
puts"#{User.count} users"
puts"#{Type.count} types"
puts"#{Category.count} types"

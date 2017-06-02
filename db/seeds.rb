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


Category.find_or_create_by(
  name: "Shortboard",
  type_id: Type.find_by(name: "Surf").id
)
Category.find_or_create_by(
  name: "Longboard",
  type_id: Type.find_by(name: "Surf").id
)
Category.find_or_create_by(
  name: "Stand Up Paddle",
  type_id: Type.find_by(name: "Surf").id
)
Category.find_or_create_by(
  name: "Snowboard",
  type_id: Type.find_by(name: "Snow").id
)
Category.find_or_create_by(
  name: "Skis",
  type_id: Type.find_by(name: "Snow").id
)
Category.find_or_create_by(
  name: "Wakeboard",
  type_id: Type.find_by(name: "Wake").id
)
Category.find_or_create_by(
  name: "Skis",
  type_id: Type.find_by(name: "Wake").id
)
Category.find_or_create_by(
  name: "Skateboard",
  type_id: Type.find_by(name: "Skate").id
)
Category.find_or_create_by(
  name: "Cruiser",
  type_id: Type.find_by(name: "Skate").id
)
Category.find_or_create_by(
  name: "Electric",
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
 zipcode: 76262,
 company: "comp1"

 )
 User.create(
 name: "ar",
 email: "ryan_blake@me.com",
 role: 0,
 password: "testtest",
 address: "123 test st",
 city: "denton",
 state: ["tx", "tx"].sample,
 zipcode: 76210,
 company: "comp2"

)

users = User.all


20.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  used:       [true, false].sample,
  description: Faker::Hipster.paragraph,
  length: Faker::Number.number(1),
  width: Faker::Number.number(1),
  volume: Faker::Number.number(1),
  type: types.sample,
  category: categories.sample,
  footgear: [true, false].sample,
  rental: [true, false].sample,
  price: rand(10..40),
  cost: rand(5..9),
  user_id: User.all.sample.id,
  pending: false,
  arrived: false,
  zipcode: [76210, 90277, 76262, 76135].sample,
  for_sale: true,
  list_time: [Time.now, Time.now - 2.weeks, Time.now - 4.weeks].sample

  )
end

20.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  used:       [true, false].sample,
  description: Faker::Hipster.paragraph,
  length: Faker::Number.number(1),
  width: Faker::Number.number(1),
  volume: Faker::Number.number(1),
  type: types.sample,
  category: categories.sample,
  footgear: [true, false].sample,
  rental: [true, false].sample,
  price: rand(10..40),
  cost: rand(5..9),
  user_id: User.all.sample.id,
  pending: false,
  arrived: false,
  zipcode: [76210, 90277, 76262, 76135].sample,
  for_sale: true,
  list_time: [Time.now, Time.now - 2.weeks, Time.now - 4.weeks].sample
  )
end
20.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  used:       [true, false].sample,
  description: Faker::Hipster.paragraph,
  length: Faker::Number.number(1),
  width: Faker::Number.number(1),
  volume: Faker::Number.number(1),
  type: types.sample,
  category: categories.sample,
  footgear: [true, false].sample,
  rental: [true, false].sample,
  price: rand(10..40),
  cost: rand(5..9),
  user_id: User.all.sample.id,
  pending: true,
  arrived: [true, false].sample,
  zipcode: [76210, 90277, 76262, 76135].sample,
  for_sale: false,
  list_time: [Time.now, Time.now - 2.weeks, Time.now - 4.weeks].sample
  )
end
  20.times do
    Board.create!(
    title:       Faker::Hipster.word,
    make:       Faker::Hipster.word,
    used:       [true, false].sample,
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
    for_sale: true,
    rental: true,
    cost: rand(5..10),
    inventory: rand(1..3),
    list_time: [Time.now, Time.now - 2.weeks, Time.now - 4.weeks].sample
    )
  end
  boards = Board.all



50.times do
  Image.create!(
  file_id: ['1687654e4eb2d536fe0d59de264c6244b92ff03da25e32f38eb94e26e539','da61df8dcdc92275d4bd48ce01cb6c8f35d4faee','15a33afca32c3f5b59b8035b17c324f198a76919bb09105dc3035a458a4d','f8ed69e4e3bcce539e368bf9509f1389c4afc0d3d5af6e37ada037a50c95'].sample,
  board_id: Board.all.sample.id
  )
end

images = Image.all

10.times do
  Event.create!(
  start_time: Time.now,
  end_time: Time.now + 2.days,
  vendor_id: 1,
  board_id: rand(60..80),
  user_id: 2
  )
end

10.times do
  Event.create!(
  start_time: Time.now - 2.weeks,
  user_id: 1,
  vendor_id: 2,
  end_time: Time.now - 1.weeks,
  board_id: rand(60..80)
  )
end

events = Event.all

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
puts"#{Category.count} cats"
puts"#{Event.count} events"

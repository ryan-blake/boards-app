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

unit_array = %w{in ft cm mm}

unit_array.each do |t|
 Unit.find_or_create_by(
  name: t
  )
end

tail_array = %w{Asym Bat Chop Diamond Pin Rocket Rounded\ Diamond Rounded\ Square Round Square Squash Star Swallow   }

tail_array.each do |t|
 Tail.create!(
  name: t
 )
end
tails = Tail.all


fin_array = %w{Quad Tri Twin Single}

fin_array.each do |t|
 Fin.find_or_create_by(
  name: t
 )
end

fins = Fin.all


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

Kind.find_or_create_by(
  name: "Paddle",
  category_id: Category.find_by(name: "Stand Up Paddle").id
)
Kind.find_or_create_by(
  name: "Fins",
  category_id: Category.find_by(name: "Stand Up Paddle").id
)
Kind.find_or_create_by(
  name: "Boots",
  category_id: Category.find_by(name: "Snowboard").id
)
Kind.find_or_create_by(
  name: "Bindings",
  category_id: Category.find_by(name: "Snowboard").id
)
Kind.find_or_create_by(
  name: "Bindings",
  category_id: Category.find_by(name: "Skis").id
)
Kind.find_or_create_by(
  name: "Bindings",
  category_id: 7
)
Kind.find_or_create_by(
  name: "Wax",
  category_id: Category.find_by(name: "Longboard").id
)
Kind.find_or_create_by(
  name: "Bindings",
  category_id: Category.find_by(name: "Wakeboard").id
)
Kind.find_or_create_by(
  name: "Wheels",
  category_id: Category.find_by(name: "Cruiser").id
)
Kind.find_or_create_by(
  name: "Leash",
  category_id: Category.find_by(name: "Longboard").id
)
Kind.find_or_create_by(
  name: "Stomp Pad",
  category_id: Category.find_by(name: "Shortboard").id
)
Kind.find_or_create_by(
  name: "Bearings",
  category_id: Category.find_by(name: "Cruiser").id
)
Kind.find_or_create_by(
  name: "Leash",
  category_id: Category.find_by(name: "Shortboard").id
)
Kind.find_or_create_by(
  name: "Wheels",
  category_id: Category.find_by(name: "Skateboard").id
)
Kind.find_or_create_by(
  name: "Fins",
  category_id: Category.find_by(name: "Shortboard").id
)
Kind.find_or_create_by(
  name: "Trucks",
  category_id: Category.find_by(name: "Skateboard").id
)
Kind.find_or_create_by(
  name: "Trucks",
  category_id: Category.find_by(name: "Electric").id
)

kinds = Kind.all

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


50.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  used:       [true, false].sample,
  description: Faker::Hipster.paragraph,
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

50.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  used:       [true, false].sample,
  description: Faker::Hipster.paragraph,
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
50.times do
  Board.create!(
  title:       Faker::Hipster.word,
  make:       Faker::Hipster.word,
  used:       [true, false].sample,
  description: Faker::Hipster.paragraph,
  width: Faker::Number.number(1),
  volume: Faker::Number.number(1),
  type: types.sample,
  category: categories.sample,
  tail: tails.sample,
  fin: fins.sample,
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
puts "#{Board.count} at board/1"
  50.times do
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
    tail: tails.sample,
    fin: fins.sample,
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
  a = 0
   100.times do
    board = Board.where(user_id: 1, type_id: 1).sample
    if a % 2 == 0
      Size.create!(
        feet: rand(1..6),
        inches: rand(0..12),
        width: rand(12.25..22.88),
        thickness: rand(2.1..12.98),
        board_id: board.id,
      )
      a += 1
    else
      Size.create!(
        feet: rand(7..10),
        inches: rand(0..12),
        width: rand(12.25..22.88),
        thickness: rand(2.1..12.98),
        board_id: board.id,
      )
      a += 1
    end

  end
  puts "#{Board.count} at sizes/1"

  boards = Board.all
  all_boards = boards.count
  board = 1
  all_boards.times do
    if board % 2 == 0
      Size.create!(
        length: rand(1..6),
        width: rand(1.19..20.88),
        board_id: board,
        unit_id: Unit.all.sample.id
      )
      board += 1
    else
      Size.create!(
        length: rand(6.1..15),
        width: rand(1.19..20.88),
        board_id: board,
        unit_id: Unit.all.sample.id
      )
      board += 1
    end


  end

    75.times do
      Accessory.create!(
        brand: ['brand1', 'brand2', 'brand3', 'brand3', 'brand4', 'brand5', 'brand6', 'brand7'].sample,
        price: rand(10..25),
        inventory: rand(1..5),
        color: ['red', 'white', 'blue', 'orange', 'yellow', 'teal', 'turqoise'].sample,
        title: ['title1','43title1','title15','title16','title112','title232','title53','title231','title8','titl21'].sample,
        user_id: User.all.sample.id,
        kind_id: Kind.all.sample.id,
        unit_id: Unit.all.sample.id,
        measure: rand(1.15..25.88)
      )
    end
    puts "#{Board.count} at access/1"
    75.times do
      board = Board.where(user_id: 1).sample
      kind =  Kind.where(category_id: board.category_id).sample

      Accessory.create!(
        brand: ['brand1', 'brand2', 'brand3', 'brand3', 'brand4', 'brand5', 'brand6', 'brand7'].sample,
        price: rand(10..25),
        inventory: rand(1..5),
        color: ['red', 'white', 'blue', 'orange', 'yellow', 'teal', 'turqoise'].sample,
        title: Faker::Hipster.word,
        board_id: board.id,
        user_id: board.user.id,
        kind_id: kind.id,
        unit_id: Unit.all.sample.id,
        measure: rand(3.9..25.1)
      )
    end
    i = 1
    a = 1
150.times do
  Image.create!(
  file_id: ['1687654e4eb2d536fe0d59de264c6244b92ff03da25e32f38eb94e26e539','04c86fb9b07208fcea64889aea5059d7c4939b5a3f5ba5edf7f00f313b9f','15a33afca32c3f5b59b8035b17c324f198a76919bb09105dc3035a458a4d','f8ed69e4e3bcce539e368bf9509f1389c4afc0d3d5af6e37ada037a50c95'].sample,
  board_id: a,
  )
  if i % 2 == 0
  a += 1
  end
  i += 1
end

  i = 1
150.times do
  Image.create!(
  file_id: ['1687654e4eb2d536fe0d59de264c6244b92ff03da25e32f38eb94e26e539','04c86fb9b07208fcea64889aea5059d7c4939b5a3f5ba5edf7f00f313b9f','15a33afca32c3f5b59b8035b17c324f198a76919bb09105dc3035a458a4d','f8ed69e4e3bcce539e368bf9509f1389c4afc0d3d5af6e37ada037a50c95'].sample,
  accessory_id: i
  )
    i += 1

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
puts"#{Accessory.count} accessories"

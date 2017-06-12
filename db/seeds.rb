
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

kinds = Kind.all



  30.times do
    Accessory.create!(
      brand: ['brand1', 'brand2', 'brand3', 'brand3', 'brand4', 'brand5', 'brand6', 'brand7'].sample,
      price: rand(10..25),
      inventory: rand(1..5),
      color: ['red', 'white', 'blue', 'orange', 'yellow', 'teal', 'turqoise'].sample,
      title: ['title1','43title1','title15','title16','title112','title232','title53','title231','title8','titl21'].sample,
      user_id: User.all.sample.id,
      kind_id: Kind.all.sample.id
    )
  end
  30.times do
    Accessory.create!(
      brand: ['brand1', 'brand2', 'brand3', 'brand3', 'brand4', 'brand5', 'brand6', 'brand7'].sample,
      price: rand(10..25),
      inventory: rand(1..5),
      color: ['red', 'white', 'blue', 'orange', 'yellow', 'teal', 'turqoise'].sample
      title: Faker::Hipster.word,
      board = Board.all.sample
      board_id: board.id,
      user_id: board.user.id,
      kind_id: Kind.where(category_id: board.category.id).id
    )
  end



50.times do
  Image.create!(
  file_id: ['1687654e4eb2d536fe0d59de264c6244b92ff03da25e32f38eb94e26e539','da61df8dcdc92275d4bd48ce01cb6c8f35d4faee','15a33afca32c3f5b59b8035b17c324f198a76919bb09105dc3035a458a4d','f8ed69e4e3bcce539e368bf9509f1389c4afc0d3d5af6e37ada037a50c95'].sample,
  board_id: Accessory.all.sample.id
  )
end

images = Image.all


puts"#{Accessory.count} accessories"

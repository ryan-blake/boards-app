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

User.create(
 name: "ryan",
 email: "ryan_blake@mac.com",
 role: 1,
 password: "testtest",
 )

 users = User.all
types = Type.all


puts"#{User.count} users"
puts"#{Type.count} types"

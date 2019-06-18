30.times do
  some_variable = User.create(
    first_name: Faker::Name.first_name,
    second_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address1: Faker::Address.street_address,
    address2: rand < 0.7 ? Faker::Address.secondary_address : nil,
    city: Faker::Address.city,
    post_code: Faker::Address.postcode
  )
end

plant1 = Plant.create(species: "Ficus", preferences: "humidity", price: 10)
plant2 = Plant.create(species: "Rubber Plant", preferences: "humidity", price: 6)
plant3 = Plant.create(species: "Snake Plant", preferences: "humidity", price: 6)
plant4 = Plant.create(species: "Jade Plant", preferences: "direct sunlight", price: 10)
plant5 = Plant.create(species: "Amaryllis", preferences: "shade", price: 8)
plant6 = Plant.create(species: "Bird Of Paradise", preferences: "hot dry climate", price: 25)
plant7 = Plant.create(species: "Orchid", preferences: "direct sunlight", price: 15)
plant8 = Plant.create(species: "Flaming Sword", preferences: "hot dry climate", price: 6)
plant9 = Plant.create(species: "Peace Lily", preferences: "humidity", price: 8)
plant10 = Plant.create(species: "Areca Palm", preferences: "hot dry climate", price: 20)
plant11 = Plant.create(species: "Peacock Plant", preferences: "hot dry climate", price: 10)
plant12 = Plant.create(species: "Honeysuckle", preferences: "direct sunlight", price: 8)
plant13 = Plant.create(species: "Engligh Ivy", preferences: "shade", price: 6)
plant14 = Plant.create(species: "Yellow Iris", preferences: "indirect light", price: 15)
plant15 = Plant.create(species: "Devils Ivy", preferences: "shade", price: 6)

30.times do
  some_other_variable = Purchase.create(
    date: Faker::Date.backward(14),
    user_id: User.all.map {|user| user.id}.sample,
    plant_id: Plant.all.map {|plant| plant.id}.sample,
    condition: rand < 0.9 ? "alive" : "dead"
  )
end
#myArray[rand(myarray.length)]
#[:foo, :bar].sample

# binding.pry

puts "-----------SEEDED------------"

# condition ? A : B
#
# if (condition)
#   return A
# else
#   return B
# end

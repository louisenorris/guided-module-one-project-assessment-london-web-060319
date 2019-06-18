30.times do
  some_other_variable = Purchase.create(
    date: Faker::Date.backward(14),
    user_id: User.all.map {|user| user.id}.sample,
    plant_id: Plant.all.map {|plant| plant.id}.sample,
    condition: rand < 0.9 ? "alive" : "dead"
  )
end

puts "-----------SEEDED------------"

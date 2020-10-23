# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

10.times do |n|
  name = Faker::TvShows::GameOfThrones.unique.character
  email = Faker::Internet.unique.email
  password = "password"
  User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password
  )
end

5.times do |n|
  count = n + 1
  Room.create!(
      name: Faker::Coffee.unique.blend_name,
      description: Faker::Coffee.unique.notes,
      host_id: count,
      group_id: count
  )

  Group.create!(
      name: Faker::TvShows::GameOfThrones.unique.house,
      description: Faker::TvShows::GameOfThrones.unique.quote,
      owner_id: count
  )

  ChatMember.create!(
      room_id: count,
      user_id: count
  )

  GroupMember.create!(
      group_id: count,
      user_id: count
  )
end

5.times do |n|
  count = n + 1
  possible_numbers = (6..10).to_a

  ChatMember.create!(
      room_id: count,
      user_id: possible_numbers.sample
  )

  GroupMember.create!(
      group_id: count,
      user_id: possible_numbers.sample
  )
end





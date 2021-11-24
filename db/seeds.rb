# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create_or_find_by(email: 'dev@hent.com.br') do |u|
  u.password = '123456789'
  u.password_confirmation = '123456789'
end

20.times do
  Book.create name: Faker::Book.title 
end

Book.first(5).each do |book|
  book.lends.create
end

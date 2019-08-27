# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# delete_all
puts "Deleting all existing content"
Game.delete_all
Course.delete_all
User.delete_all
ListPref.delete_all

puts "Creating categories and other arrays"
price = (20..100).to_a
holes = ['18 holes', '9 holes', 'Driving range']
d1 = Date.tomorrow
d2 = Date.new(2019, 9, 2)
d3 = Date.new(2019, 9, 15)
t1 = Time.now.utc.strftime( "%H%M%S%N" )
t2 = Time.now.utc.strftime( "%H%M%S%N" )
t3 = Time.now.utc.strftime( "%H%M%S%N" )
list = %w(Adventurous Helpful Affable Humble Capable Imaginative Charming Impartial Confident Independent Conscientious Keen Cultured Meticulous Dependable Observant)

puts "Creating 10 users"
10.times { User.create(name: Faker::Name.name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password, about_me: Faker::Lorem.paragraph, current_city: Faker::Address.city )}

puts "Creating 5 courses"
Course.create(name: 'Club de Golf Metropolitain Anjou', address: '9555 Boulevard Du Golf, Anjou', difficulty: 1, number_holes: 18, style: 'Classic')
Course.create(name: 'Golf Les Iles de Boucherville', address: '255, Ile Sainte-Marguerite, Boucherville', difficulty: 3, number_holes: 18, style: 'Links')
Course.create(name: 'Golf Dorval', address: '2000 avenue Reverchon, Dorval', difficulty: 3, number_holes: 18, style: 'Championship')
Course.create(name: 'Golf Ste-Rose', address: '1400 Mattawa Boulevard, Laval', difficulty: 2, number_holes: 18, style: 'Classic')
Course.create(name: 'Mystic Pines', address: '1500 Route 138, Kahnawake', difficulty: 1, number_holes: 9, style: 'Links')


puts "Creating 10 games"
10.times { Game.create(
  name: Faker::Restaurant.name,
  options: holes.sample,
  number_players: [3, 4].sample,
  number_guests: [1, 2].sample,
  date: [d1, d2, d3].sample,
  time: [d1, d2, d3].sample,
  booked: [0, 1].sample,
  tournament: [0, 1].sample,
  about_game: Faker::Lorem.paragraph,
  course: Course.all.sample,
  user: User.all.sample,
  game_price: price.sample
  ) }

puts "Thank you for your patience!"

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
Wishlist.delete_all
UserPreference.delete_all
ListPref.delete_all
User.delete_all

puts "Creating categories and other arrays"
price = (20..100).to_a
holes = ['18 holes', '9 holes', 'Driving range']
d1 = Date.yesterday
d2 = Date.tomorrow
d3 = Date.new(2019, 9, 2)
d4 = Date.new(2019, 9, 15)
t1 = Time.now
t2 = Time.now
t3 = Time.now
list = %w(Adventurous Helpful Affable Humble Capable Imaginative Charming Impartial Confident Independent Conscientious Keen Cultured Meticulous Dependable Observant)

puts "Creating 10 users + 1 admin"
10.times do
  User.create!(
  name: Faker::Name.first_name + Faker::Name.last_name,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  about_me: Faker::Lorem.paragraph,
  current_city: Faker::Address.city,
  gender: ['Female', 'Male', 'Other'].sample,
  remote_photo_url: 'https://source.unsplash.com/300x300/?face',
  )
  puts 'Dormance de 3 secondes'
  sleep(3)
end
User.create!(name: 'info GOLFY Buddy', first_name: 'info', last_name: 'GOLFY Buddy', email: 'info@golfybuddy.com', password: '123456', about_me: "I am the admin", current_city: 'Montreal', gender: 'Other')

puts 'Creation de younes@email.com:123456'
User.create!(name: 'Younes Kamel', first_name: 'Younes', last_name: 'Kamel', email: 'younes@email.com', password: '123456', about_me: "I am Younes", current_city: 'Montreal', gender: 'Other', photo: File.open('./app/assets/images/younes.jpg'))
puts 'Creation de leo@email.com:123456'
User.create!(name: 'Leo Beltran', first_name: 'Leo', last_name: 'Beltran', email: 'leo@email.com', password: '123456', about_me: "I am a guest", current_city: 'Montreal', gender: 'Other', photo: File.open('./app/assets/images/leo.jpg'))
puts 'Creation de fred@email.com:123456'
User.create!(name: 'Frederic Thomas', first_name: 'Frederic', last_name: 'Thomas', email: 'fred@email.com', password: '123456', about_me: "I am a guest", current_city: 'Montreal', gender: 'Other', photo: File.open('./app/assets/images/fred.png'))
puts 'Creation de louis@email.com:123456'
User.create!(name: 'Louis-Olivier', first_name: 'Louis-Olivier', last_name: 'Pelletier', email: 'louis@email.com', password: '123456', about_me: "I am a guest", current_city: 'Montreal', gender: 'Other', photo: File.open('./app/assets/images/louis.png'))

puts "Generating users's wishlist"
User.all.each do |user|
  Wishlist.create!(user: user)
end

puts "Creating 5 courses"
Course.create!(name: 'Club de Golf Metropolitain Anjou', address: '9555 Boulevard Du Golf, Anjou', difficulty: 1, number_holes: 18, style: 'Classic')
Course.create!(name: 'Golf Les Iles de Boucherville', address: '255, Ile Sainte-Marguerite, Boucherville', difficulty: 3, number_holes: 18, style: 'Links')
Course.create!(name: 'Golf Dorval', address: '2000 avenue Reverchon, Dorval', difficulty: 3, number_holes: 18, style: 'Championship')
Course.create!(name: 'Golf Ste-Rose', address: '1400 Mattawa Boulevard, Laval', difficulty: 2, number_holes: 18, style: 'Classic')
Course.create!(name: 'Mystic Pines', address: '1500 Route 138, Kahnawake', difficulty: 1, number_holes: 9, style: 'Links')

courses = Course.all
courses.map do |course|
  course.attachments.create!(remote_photo_url: 'https://source.unsplash.com/random/?golf-course')
  sleep(5)
  puts 'Dormance de 5 secondes'
end

puts "Creating 10 games"
10.times { Game.create!(
  name: Faker::Team.name,
  options: holes.sample,
  number_players: [3, 4].sample,
  number_guests: [1, 2].sample,
  date: [d1, d2, d3, d4].sample,
  time: [t1, t2, t3].sample,
  booked: [0, 1].sample,
  tournament: [0, 1].sample,
  about_game: Faker::Lorem.paragraph,
  course: Course.all.sample,
  user: User.all.sample,
  game_price: price.sample
  ) }

puts "Create list of pref"
list.each do |pref|
    ListPref.create!(name: pref)
  end

puts "Attaching pref and perso to users"
users = User.all
  users.map do |user|
    5.times {user.user_preferences.create!(list_pref: ListPref.all.sample) }
  end


puts "Thank you for your patience!"

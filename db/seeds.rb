# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# delete_all
puts "Deleting all existing content"
Guest.delete_all
Game.delete_all
Course.delete_all
Wishlist.delete_all
UserPreference.delete_all
ListPref.delete_all
Like.delete_all
User.delete_all

puts "Creating categories and other arrays"
price = (20..100).to_a
holes = ['18 holes', '9 holes', 'Driving range']
lang = ['English', 'French', 'Spanish']
d1 = DateTime.tomorrow + 1
d2 = DateTime.tomorrow
d3 = DateTime.new(2019, 9, 24)
d4 = DateTime.new(2019, 10, 6)
list = %w(Adventurous Helpful Affable Humble Capable Imaginative Charming Impartial Confident Independent Conscientious Keen Cultured Meticulous Dependable Observant)

puts "Creating GOLFY Buddy dev team"
User.create!(name: 'info GOLFY Buddy', first_name: 'info', last_name: 'GOLFY Buddy', email: 'info@golfybuddy.com', password: '123456', about_me: "I am the admin", current_city: 'Montreal', gender: 'Other')
puts 'Creation de younes@email.com:123456'
User.create!(name: 'Younes Kamel', first_name: 'Younes', last_name: 'Kamel', language: "French", handicap: rand(0..54), email: 'younes@email.com', password: '123456', about_me: "I am Younes", current_city: 'Montreal', gender: 'Male', photo: File.open('./app/assets/images/younes.jpg'))
puts 'Creation de leo@email.com:123456'
User.create!(name: 'Leo Beltran', first_name: 'Leo', last_name: 'Beltran', language: "French", handicap: rand(0..54), email: 'leo@email.com', password: '123456', about_me: "I am a guest", current_city: 'Montreal', gender: 'Male', photo: File.open('./app/assets/images/leo.jpg'))
puts 'Creation de fred@email.com:123456'
User.create!(name: 'Fred Thomas', first_name: 'Frederic', last_name: 'Thomas', language: "French", handicap: rand(0..54), email: 'fred@email.com', password: '123456', about_me: "I am a guest", current_city: 'Montreal', gender: 'Male', photo: File.open('./app/assets/images/fred.png'))
puts 'Creation de louis@email.com:123456'
User.create!(name: 'Louis-Olivier', first_name: 'Louis-Olivier', last_name: 'Pelletier', language: "French", handicap: rand(0..54), email: 'louis@email.com', password: '123456', about_me: "I am a guest", current_city: 'Montreal', gender: 'Male', photo: File.open('./app/assets/images/louis.png'))
puts 'Creation de tiger@email.com:123456'
User.create!(name: 'Tiger Woods', first_name: 'Tiger', last_name: 'Woods', language: "English", handicap: 0, email: 'tiger@email.com', password: '123456', about_me: "I won some tounaments when I was younger. Oh and BTW, I won the Masters last year!", current_city: 'Jupiter', gender: 'Male', photo: File.open('./app/assets/images/tiger-woods.jpg'))

puts "Creating 20 users + 1 admin"
20.times do
  User.create!(
  # name: Faker::Name.first_name + Faker::Name.last_name,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  about_me: Faker::Lorem.paragraph,
  current_city: Faker::Address.city,
  gender: ['Female', 'Male', 'Other'].sample,
  remote_photo_url: 'https://source.unsplash.com/300x300/?face',
  handicap: rand(0..54),
  language: lang.sample,
  )
  puts '3 secondes sleep'
  sleep(3)
end



puts "Generating users's wishlist"
User.all.each do |user|
  Wishlist.create!(user: user)
end

# puts "Creating 5 courses"
# Course.create!(name: 'Club de Golf Metropolitain Anjou', address: '9555 Boulevard Du Golf, Anjou', difficulty: 1, number_holes: 18, style: 'Classic')
# Course.create!(name: 'Golf Les Iles de Boucherville', address: '255, Ile Sainte-Marguerite, Boucherville', difficulty: 3, number_holes: 18, style: 'Links')
# Course.create!(name: 'Golf Dorval', address: '2000 avenue Reverchon, Dorval', difficulty: 3, number_holes: 18, style: 'Championship')
# Course.create!(name: 'Golf Ste-Rose', address: '1400 Mattawa Boulevard, Laval', difficulty: 2, number_holes: 18, style: 'Classic')
# Course.create!(name: 'Mystic Pines', address: '1500 Route 138, Kahnawake', difficulty: 1, number_holes: 9, style: 'Links')

# courses = Course.all
# courses.map do |course|
#   course.attachments.create!(remote_photo_url: 'https://source.unsplash.com/random/?golf-course')
#   sleep(5)
#   puts '5 secondes sleep'
# end

# puts "Creating 20 games"
# 20.times { Game.create!(
#   name: Faker::Team.name,
#   options: holes.sample,
#   number_players: [2, 3, 4].sample,
#   time: [d1, d2, d3, d4].sample,
#   booked: [0, 1].sample,
#   tournament: [0, 1].sample,
#   about_game: Faker::Lorem.paragraph,
#   course: Course.all.sample,
#   user: User.all.sample,
#   game_price: price.sample
#   likes: rand(3..126)
#   ) }

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

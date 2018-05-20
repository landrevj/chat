# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

board_list = [
  ['misc', 'General'],
  ['meme', 'Funposting'],
  ['auto', 'Automobiles'],
  ['nat', 'Nature'],
  ['tech', 'Technology'],
  ['dev', 'Development'],
  ['tv', 'Television'],
  ['v', 'Video Games'],
  ['vg', 'Video Game Generals'],
  ['tg', 'Traditional Games'],
  ['sci', 'Science'],
  ['bis', 'Business'],
  ['co', 'Comics'],
  ['sp', 'Sports'],
  ['ph', 'Photography'],
  ['cook', 'Cooking'],
  ['lit', 'Literature'],
  ['mu', 'Music'],
  ['fit', 'Fitness'],
  ['news', 'Current News'],
]

board_list.each do |abbreviation, name|
  Board.create(name: name, abbreviation: abbreviation)
end

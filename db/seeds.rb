# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  'Anna',
  'Anomaly Warzone Earth',
  'BIT.TRIP Runner',
  'Brütal Legend',
  'Costume Quest',
  'Dota 2',
  'Duke Nukem 3D: Megaton Edition',
  'Faster Than Light',
  'Gratuitous Space Battles',
  'Half-Life 2',
  'Indie Game: The Movie',
  'Left 4 Dead 2',
  'Magicka',
  'Mark of the Ninja',
  'Offspring Fling!',
  'Portal 2',
  'Psychonauts',
  'Saints Row: The Third',
  'Space Pirates and Zombies',
  'Stacking',
  'Steam Summer Getaway',
  'Team Fortress 2',
  'Terraria',
  'The Binding of Isaac',
  'The Walking Dead',
  'Trine 2'
].each do |game_name|
  Game.where(:name => game_name).first_or_create
end

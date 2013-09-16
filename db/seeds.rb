# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Game.where(:name => 'Dota 2').first_or_create
Game.where(:name => 'Trine 2').first_or_create
Game.where(:name => 'Brütal Legend').first_or_create
Game.where(:name => 'Team Fortress 2').first_or_create

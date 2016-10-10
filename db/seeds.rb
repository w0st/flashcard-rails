# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'user@domain.com', password: 'password', password_confirmation: 'password')
group = Group.create(name: 'Office English', user: user)
Card.create(front: 'stapler', back: 'zszywacz', group: group)
Card.create(front: 'appointment book', back: 'terminarz', group: group)
Card.create(front: 'sellotape', back: 'taśma klejąca', group: group)


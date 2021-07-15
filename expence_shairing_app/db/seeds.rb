# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Expense
Expense.find_or_create_by(name: 'Food')
Expense.find_or_create_by(name: 'Transport')
Expense.find_or_create_by(name: 'Gas')
Expense.find_or_create_by(name: 'Electricity')
Expense.find_or_create_by(name: 'Beverage')

#User
	 user = User.find_or_create_by(first_name: 'Athira', last_name: 'Ramanan', email: 'athirar@gmail.com').save(validate: false)
	 user.password = 'password'
	 user.save
#Group
	Group.find_or_create_by(name: 'Home', owner_id: User.first.id)


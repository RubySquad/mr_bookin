# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['Customer', 'Manager', 'Admin', 'Banned'].each do |role|
  Role.find_or_create_by({name: role})
end

['USA', 'Ukraine', 'Poland', 'Canada'].each do |country|
  Country.find_or_create_by({name: country})
end

User.find_or_create_by({email: 'admin@mrbookin.com'}) do |user|
  user.firstname = 'Admin'
  user.lastname = 'Admin'
  user.role_id = Role.find_by_name('Admin')
  user.password = '$2a$10$wzHfYwOrbFhwh2ZPnH48VeGlDpSZPVCNt9328eYDeZ4lPIziSJ9TS' #AdminAdmin
end
  
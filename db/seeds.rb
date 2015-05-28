# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Staff.create(staff_name: "Oli De Paolis", staff_email: "olidepaolis@gmail.com", password: "asd", admin: true)
Staff.create(staff_name: "Andrew Clark", staff_email: "andrew@pearlcom.co.uk", password: "asd", admin: true)
Type.create(department: "Wiping")
Type.create(department: "Shipping")
Type.create(department: "Receiving")
Type.create(department: "Decommissioning")
Type.first.staffs << Staff.first
Type.first.staffs << Staff.second
Hub.create(hub_location: "Midlothian Innovation Centre, Pentlandfield, Roslin, Midlothian, EH25 9RE")
OperatingSystem.create(os: "No OS")
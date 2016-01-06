# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Category.create!( :name => "conf" )
Category.create!( :name => "meetup" )
Category.create!( :name => "foo" )
Category.create!( :name => "bar" )
Category.create!( :name => "zoo" )


Group.create!( :name => "ruby" )
Group.create!( :name => "js" )
Group.create!( :name => "css" )
Group.create!( :name => "scala" )
Group.create!( :name => "coffee" )
Group.create!( :name => "R" )
Group.create!( :name => "C++" )
Group.create!( :name => "C" )

namespace :dev do

  task :generate_user_token => :environment do
    User.find_each do |u|
      puts "generate user #{u.id} token"
      u.generate_authentication_token
      u.save!
    end
  end

  task :fake => :environment do
    puts "generating fake data..."

    Topic.delete_all
    Comment.delete_all
    User.delete_all

    users = []

    users << User.create!( :email => "ihower@gmail.com", :fullname => "ihower C.", :username => "ihower", :password => "12345678" )

    10.times do
      users << User.create!( :fullname => Faker::Name.name, :email => Faker::Internet.email, :username => Faker::Internet.user_name, :password => "12345678" )
    end

    100.times do |i|
      puts "Fake Topic #{i}"
      t = Topic.create!( :title => Faker::Company.buzzword, :content => Faker::Lorem.paragraph, :user => users.sample )

      rand(10).times do |j|
        t.comments.create!( :content => Faker::Lorem.paragraph, :user => users.sample )
      end

    end

  end

end

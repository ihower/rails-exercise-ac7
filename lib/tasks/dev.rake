namespace :dev do

  task :fake => :environment do
    puts "generating fake data..."

    Topic.delete_all
    Comment.delete_all

    100.times do |i|
      puts "Fake Topic #{i}"
      t = Topic.create!( :title => Faker::Company.buzzword, :content => Faker::Lorem.paragraph )

      rand(10).times do |j|
        t.comments.create!( :content => Faker::Lorem.paragraph )
      end

    end

  end

end
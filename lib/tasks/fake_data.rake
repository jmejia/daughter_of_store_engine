namespace :db do
  desc "Fill database with fake stores"
  task populate: :environment do
    stores = Store.all

    count = 0
    10.times do |s|
      count += 1
      puts "store #{count}"
      stores << Store.create!(description: Faker::Lorem.sentence,
                    name: Faker::Lorem.word.capitalize + (" ") + Faker::Lorem.word.capitalize,
                    slug: "random-url-#{s+1}",
                    status: "status"
                    )
    end

    # creates fake categories for each store
    count = 0
    10.times do |c|
      count += 1
      puts "category #{count}"
      stores.each do |store|
        store.categories.create!(name: Faker::Lorem.word.capitalize)
      end
    end

    # creates fake products for each store
    count = 0
    20.times do |p|
      count += 1
      puts "product #{count}"
      retired = "retired"
      stores.each {|store| store.products.create!(description: Faker::Lorem.sentence,
                                                  name: Faker::Lorem.word.capitalize,
                                                  price: 300000 + Random.rand(100000),
                                                  #category_ids: [store.category_ids.sample],
                                                  category_ids: store.categories.sample.id,
                                                  image_name: 1 + rand(110)
                                                  )}
    end


    # creates fake admins and fake stockers for each store
    stores.each_with_index do |store, index|
      puts "store #{index}"
      2.times do |i|
        begin
          user = User.create!(full_name: Faker::Name.first_name,
                              password: "password",
                              email: "#{rand(100000).to_s}@epicsale.com"
                             )
          store.add_admin(user)
        rescue
          puts "email taken! retrying."
          retry
        end
      end

      2.times do |i|
        begin
          user = User.create!(full_name: Faker::Name.first_name,
                              password: "password",
                              email: "#{rand(100000).to_s}@epicsale.com"
                             )
          store.add_stocker(user)
        rescue
          puts "email taken! retrying."
          retry
        end
      end
    end
  end

  desc "Fill database with fake users"
  task populate: :environment do
    count = 0
    50.times do |u|
      count += 1
      puts "user #{count}"
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      user = User.create!(full_name: "#{first_name} #{last_name}",
                   display_name: "#{first_name[0]}#{last_name}",
                   email: "example-#{u+1}@epicsale.com",
                   password: "password",
                   password_confirmation: "password",
                   platform_administrator: false
                  )
    end
  end

  desc "Create fake orders"
  task populate: :environment do
    GlobalFee.create(amount: 5)
    count = 0
    100.times do |o|
      count += 1
      puts "order #{count}"
      user_id = rand(1..50)
      total_cost = rand(1..10000000)
      store_id = rand(1..21)
      order = Order.create!(user_id: user_id, total_cost: total_cost, store_id: store_id, status: "paid")
      order.created_at = Date.today.ago(1.month - 1.day)
      order.save
    end
  end
end

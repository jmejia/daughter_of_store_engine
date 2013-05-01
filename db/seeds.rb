# STORES
store = Store.create!(name: "Oregon Sale", slug:"oregon-sale", status: "enabled")
# store2 = Store.create!(name: "TR's Treasures", slug:"trs-treasures", status: "enabled")

# CATEGORIES
c1 = Category.new(name: "Grub")
c1.store = store
c1.save!
c2 = Category.new(name: "Clothing")
c2.store = store
c2.save!
c3 = Category.new(name: "Weapons")
c3.store = store
c3.save!
c4 = Category.new(name: "Tools")
c4.store = store
c4.save!
c5 = Category.new(name: "Medicine")
c5.store = store
c5.save!
c6 = Category.new(name: "Essentials")
c6.store = store
c6.save!

#GRUB
p=Product.new( name: "Rations", price: 24,
  description:"Good for one 'splorer.", category_ids: [c1.id])
p.store = store
p.save!

p=Product.new( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.", category_ids: [c1.id])
p.store = store
p.save!

p=Product.new( name: "Apples", price: 19,
  description: "Great for a snack!", category_ids: [c1.id])
p.store = store
p.save!

p=Product.new( name: "Hardtack", price: 40,
  description: "Simple cracker for simple folk.", category_ids: [c1.id])
p.store = store
p.save!

p=Product.new( name: "Prickly Pear", price: 60,
  description: "Prickly on the outside, scrumptious on the inside.", category_ids: [c1.id])
p.store = store
p.save!
p=Product.new( name: "Bacon", price: 100,
  description: "By the slab for the whole fam!", category_ids: [c1.id])
p.store = store
p.save!
p=Product.new( name: "Sarsaparilla", price: 3,
  description: "Before Coke, there was sarsaparilla.", category_ids: [c1.id])
p.store = store
p.save!

#CLOTHING
p=Product.new( name: "Basic Tunic", price: 75,
  description: "Plain ol' get-up for simple folk.", category_ids: [c2.id])
p.store = store
p.save!
p=Product.new( name: "Leather Armor", price: 250,
  description: "Good fer fendin' off 'coons and der sharp claws.", category_ids: [c2.id])
p.store = store
p.save!
p=Product.new( name: "Ponchos", price: 25,
  description: "It gets rainy on the trail. Better bring a poncho.", category_ids: [c2.id])
p.store = store
p.save!
p = Product.new( name: "Moccasins", price: 196,
  description: "Made with real Apache tears!", category_ids: [c2.id])
p.store = store
p.save!
p=Product.new( name: "Camouflage", price: 50,
  description: "Der buffalo won't be able to see yer.", category_ids: [c2.id])
p.store = store
p.save!

#WEAPONS
p=Product.new( name: "Blunderbuss", price: 150,
  description: "Big ol' gun, and loads of fun!", category_ids: [c3.id])
p.store = store
p.save!
p=Product.new( name: "Navy Revolver", price: 500,
  description: "Great for fightin' off vermits!", category_ids: [c3.id])
p.store = store
p.save!
p=Product.new( name: "Volcano Pistol", price: 891,
  description: "Bandits ain't gonna be stealin' none of you'ns rations.", category_ids: [c3.id])
p.store = store
p.save!
p=Product.new( name: "Kentucky Rifle", price: 250,
  description: "Good fer huntin' squirrels 'n' such.", category_ids: [c3.id])
p.store = store
p.save!
p=Product.new( name: "Buffalo Rifle", price: 1000,
  description: "Dis here's a one-shot K.O. Big gun fer big game.", category_ids: [c3.id])
p.store = store
p.save!

#TOOLS
p=Product.new( name: "Stone Hunting Knife", price: 98,
  description: "Good fer fur.", category_ids: [c3.id, c4.id])
p.store = store
p.save!
p=Product.new( name: "Snake Charm", price: 25,
  description: "Never git bit by a slippery snake 'gin!", category_ids: [c4.id])
p.store = store
p.save!
p=Product.new( name: "Compass", price: 62,
  description: "West is where yer headed, so's ya know.", category_ids: [c4.id])
p.store = store
p.save!
p=Product.new( name: "Sleeping Bag", price: 3,
  description: "Regain staminer! Warm 'n' cozy.", category_ids: [c4.id])
p.store = store
p.save!
p=Product.new( name: "Carpenter's Tools", price: 400,
  description: "Fer fixin' up der wagon in a jiff!", category_ids: [c4.id])
p.store = store
p.save!
p=Product.new( name: "Divining Rod", price: 500,
  description: "Water, water, anywhere? And lots and lots to drink!", category_ids: [c4.id])
p.store = store
p.save!

#MEDICINE
p=Product.new( name: "Miracle Cure", price: 3000,
  description: "Completely cures anything.", category_ids: [c5.id])
p.store = store
p.save!
p=Product.new( name: "Antivenom", price: 15,
  description: "Heals yer snakebite in a jiff.", category_ids: [c5.id])
p.store = store
p.save!
p=Product.new( name: "Lemon", price: 15,
  description: "Cures scurvy and tastes great too!", category_ids: [c1.id, c5.id])
p.store = store
p.save!
p=Product.new( name: "Medicine bag", price: 1000,
  description: "All yer fixin's in one handy sack.", category_ids: [c5.id])
p.store = store
p.save!
p=Product.new( name: "Cod Liver Oil", price: 10,
  description: "Tastes like dung. But good fer yer body.", category_ids: [c5.id])
p.store = store
p.save!

#ESSENTIALS
p=Product.new( name: "Oxen", price: 4000,
  description: "Strong, durable, and more MPG than yer SUV.", category_ids: [c6.id])
p.store = store
p.save!
p=Product.new( name: "Guide", price: 15000,
  description: "Well hey there, partner! I'm here to help.", category_ids: [c6.id])
p.store = store
p.save!
p=Product.new( name: "Wagon", price: 15000,
  description: "Made of wood, so you know it's good.", category_ids: [c6.id])
p.store = store
p.save!
p=Product.new( name: "Tombstone", price: 1000,
  description: "Cause one person always gets off'd on the Oregon Trail. Always.", category_ids: [c6.id])
p.store = store
p.save!

#RETIRED
p=Product.new( name: "Peacoat", price: 3000,
  description: "Classy coat for the classy gent.", category_ids: [c1.id], retired: true)
p.store = store
p.save!

#STORE2 Products
# p=Product.new( name: "Necklace", price: 1000,
#   description: "Purdy", category_ids: [])
# p.store = store2
# p.save!

#USERS
User.create!(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com",
  password: "password", role: :user, display_name: nil)
User.create!(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com",
  password: "password", role: :admin, display_name: "j3")
User.create!(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com",
  password: "password", role: :superuser, display_name: "SkrilleX", platform_administrator: "true")
User.create!(full_name: "Katrina Owen", email: "demoXX+katrina@jumpstartlab.com",
  password: "password", role: :user, display_name: "Ree-na")
User.create!(full_name: "Meriwether Lewis", email: "mlewis@epicsale.com",
  password: "password", role: :superuser, display_name: "MeriLewis", platform_administrator: "true")
User.create!(full_name: "William Clark", email: "wclark@epicsale.com",
  password: "password", role: :superuser, display_name: "WillClark", platform_administrator: "true")

#LINE ITEMS
##1
LineItem.create!(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)
LineItem.create!(product_id: 2, cart_id: nil,
  order_id: 1, quantity: 4, price: 200)
LineItem.create!(product_id: 3, cart_id: nil,
  order_id: 1, quantity: 5, price: 500)
##2
LineItem.create!(product_id: 25, cart_id: nil,
  order_id: 2, quantity: 1, price: 300)
LineItem.create!(product_id: 26, cart_id: nil,
  order_id: 2, quantity: 15, price: 205)
LineItem.create!(product_id: 6, cart_id: nil,
  order_id: 2, quantity: 4, price: 1000)
##3
LineItem.create!(product_id: 7, cart_id: nil,
  order_id: 3, quantity: 7, price: 600)
LineItem.create!(product_id: 10, cart_id: nil,
  order_id: 3, quantity: 1, price: 5)
##4
LineItem.create!(product_id: 1, cart_id: nil,
  order_id: 4, quantity: 1, price: 377)
LineItem.create!(product_id: 15, cart_id: nil,
  order_id: 4, quantity: 1, price: 111)
##5
LineItem.create!(product_id: 13, cart_id: nil,
  order_id: 5, quantity: 1, price: 800)
##6
LineItem.create!(product_id: 12, cart_id: nil,
  order_id: 6, quantity: 6, price: 123)
LineItem.create!(product_id: 11, cart_id: nil,
  order_id: 6, quantity: 2, price: 111)
LineItem.create!(product_id: 17, cart_id: nil,
  order_id: 6, quantity: 2, price: 89)
##7
LineItem.create!(product_id: 9, cart_id: nil,
  order_id: 7, quantity: 2, price: 4)
##8
LineItem.create!(product_id: 8, cart_id: nil,
  order_id: 8, quantity: 20, price: 800)
##9
LineItem.create!(product_id: 31, cart_id: nil,
  order_id: 9, quantity: 1, price: 444)
LineItem.create!(product_id: 32, cart_id: nil,
  order_id: 9, quantity: 2, price: 1230)
LineItem.create!(product_id: 33, cart_id: nil,
  order_id: 9, quantity: 3, price: 500)
LineItem.create!(product_id: 10, cart_id: nil,
  order_id: 9, quantity: 4, price: 110)
##10
LineItem.create!(product_id: 24, cart_id: nil,
  order_id: 10, quantity: 5, price: 80)
LineItem.create!(product_id: 23, cart_id: nil,
  order_id: 10, quantity: 6, price: 10)

#ORDERS
# o1 = Order.create!(status: "pending", user_id: 1, total_cost: 3372, store_id: 1)
# o1.update_attribute(:created_at, "2013-03-02 00:00:00")
# o2 = Order.create!(status: "pending", user_id: 4, total_cost: 7375, store_id: 1)
# o2.update_attribute(:created_at, "2013-03-02 00:00:00")
# o3 = Order.create!(status: "cancelled", user_id: 1, total_cost: 4205, store_id: 1)
# o3.update_attribute(:created_at, "2013-03-02 00:00:00")
# o4 = Order.create!(status: "cancelled", user_id: 1, total_cost: 488, store_id: 1)
# o4.update_attribute(:created_at, "2013-03-02 00:00:00")
# o5 = Order.create!(status: "paid", user_id: 4, total_cost: 800, store_id: 1)
# o5.update_attribute(:created_at, "2013-03-02 00:00:00")
# o6 = Order.create!(status: "paid", user_id: 1, total_cost: 1138, store_id: 1)
# o6.update_attribute(:created_at, "2013-03-02 00:00:00")
# o7 = Order.create!(status: "shipped", user_id: 4, total_cost: 800, store_id: 1)
# o7.update_attribute(:created_at, "2013-03-02 00:00:00")
# o8 = Order.create!(status: "shipped", user_id: 4, total_cost: 16000, store_id: 1)
# o8.update_attribute(:created_at, "2013-03-02 00:00:00")
# o9 = Order.create!(status: "returned", user_id: 1, total_cost: 4844, store_id: 1)
# o9.update_attribute(:created_at, "2013-03-02 00:00:00")
# o10 = Order.create!(status: "returned", user_id: 4, total_cost: 460, store_id: 1)
# o10.update_attribute(:created_at, "2013-03-02 00:00:00")

#ROLES
Role.create!(title: "admin")
Role.create!(title: "stocker")

#INVOICES
#Invoice.create!(store_id: 1, start_date: Date.new(2010,10,01), end_date: Date.new(2010,10,20), total_revenue: 300, fee_amount: 15)

#USER ROLES
#UserStore.create!(user_id: user1.id, store_id: store.id, role_id: 1)
# UserStore.create!(user_id: 1, store_id: 2, role_id: 1)

#GLOBAL FEE
# GlobalFee.create(amount: 5)
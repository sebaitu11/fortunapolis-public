# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  auctions = [
  [ 4, 1 ,1,1],
  [ 3, 3 ,2,2],
  [ 4, 2 ,1,3],
  [ 2, 1 ,3,4],
  [ 4, 4 ,1,5],
  [ 3, 1 ,1,6],
  [ 4, 2 ,3,7],
  [ 2, 4 ,3,8],
  [ 10, 2 ,1,9],
  [ 10, 2 ,1,10]
    ]
  auctions.each do |bets, tickets, category,product|
    Auction.create( total_bets: bets, tickets_by_bet: tickets , category_id: category, product_id: product)
  end

  products = [
  [ "iphone 5", "64gb, Space Gray" ,"iphone"],
  [ "ipad mini", "16Gb, Silver", "ipad" ],
  [ "ipod touch","64Gb, Black" ,"ipod"],
  [ "macmini", "I5 2.0, 4Gb","macmini"],
  [ "iphone 5c","32Gb Blue" ,"iphone5c"],
  [ "galaxy s4", "16Gb White" ,"galaxy"],
  [ "macbookpro","I7 2.4, 16Gb","macbook"],
  [ "imac","I7 3.0, 16Gb" ,"imac"],
  [ "Nexus 5"," Black 16gb" ,"nexus"],
  [ "Moto G","Black 32Gb" ,"motog"]
  ]

  products.each do |name, description, image, auction_id|
    Product.create( name: name, description: description, image: image)
  end

  users = [
    [ "sebaitu11@gmail.com", 31893189,31893189],
    ["eddie@gmail.com",12345678,12345678]
  ]

  users.each do |email, password, password_confirmation|
    User.create( email: email, password: password, password_confirmation: password_confirmation)
  end

  categories = [
    "phones",
    "tablets",
    "pcs"
  ]

  categories.each do |name|
    Category.create(name: name)
  end

  100.times do 
    Ticket.create( valor: 990, user_id: 1 )
  end





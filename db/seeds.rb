# User.create([
#   {
#     first_name: "Kei",
#     last_name: "Ricecake",
#     email: "kei@gmail.com",
#     image_url: "https://mobile-cuisine.com/wp-content/uploads/2012/11/rice-cake-fun-facts.jpg",
#     password: "password",
#     chef: true,
#     phone: "2223455",
#     address: "98776 Avenue, Chicago IL, 60654",
#     bio: "For over 30 years, Kei has honed her craft with both knife and pen. She started working on windjammers as a mess cook and quickly developed a lifelong passion for cooking, gardening, sailing and outdoor living."
#   },
#   {
#     first_name: "Goose",
#     last_name: "Diegans",
#     email: "goose@gmail.com",
#     image_url: "https://www.allaboutbirds.org/guide/assets/photo/59953191-480px.jpg",
#     password: "password",
#     chef: true,
#     phone: "1234567",
#     address: "123 Street, Chicago IL, 60647",
#     bio: "A highly acclaimed food writer and recipe developer, Goose has penned culinary content on everything from Hawaiian cuisine to vegan sausage making."
#   },
#   {
#     first_name: "Rae",
#     last_name: "Bex",
#     email: "raebex@gmail.com",
#     image_url: "https://post.medicalnewstoday.com/wp-content/uploads/2020/08/full-moon-night-landscape-732x549-thumbnail-1.jpg",
#     password: "password",
#     chef: false,
#     phone: "4447777",
#     address: "456 Lane, Chicago IL, 60601",
#     bio: "Analyst. Web ninja. Passionate music practitioner. Total introvert. Lifelong food fanatic. Vegan bacon maven. Troublemaker. Entrepreneur."
#   },
#   {
#     first_name: "Olivia",
#     last_name: "Mendoza",
#     email: "olivia@gmail.com",
#     image_url: "https://media.istockphoto.com/photos/olives-on-white-picture-id1141250153?k=6&m=1141250153&s=612x612&w=0&h=c9qsfBWeTYilqhiKJbMYRKOff3DOF4lgevXRn3rQRvM=",
#     password: "password",
#     chef: false,
#     phone: "8889999",
#     address: "123 Street, Kalamazoo, MI, 50031",
#     bio: "Infuriatingly humble web nerd. Twitteraholic. Writer. Hipster-friendly music aficionado. Organizer. Creator."
#   }
# ])

# Dish.create([
#   {
#     name: "Avocado Brownie",
#     price: 3.25,
#     description: "Vegan brownie that subs avocado for butter.",
#     user_id: 2,
#     image_url: "https://cdn2.mypcoskitchen.com/wp-content/uploads/2019/01/avocado-brownies-mpk.jpg",
#     portion_size: "1 brownie",
#     featured: true
#   },
#   {
#     name: "Apple Donut",
#     price: 2.96,
#     description: "Flour donut stuffed with apple jelly. Vegan!",
#     user_id: 2,
#     image_url: "https://i.pinimg.com/736x/ea/ce/02/eace02b42398907265323036fae9331a.jpg",
#     portion_size: "1 donut",
#     featured: false
#   },
#   {
#     name: "Pad See Eiw",
#     price: 9.95,
#     description: "Stir-fried wide rice noodle in sauce, carrot, broccoli, and egg.",
#     user_id: 1,
#     image_url: "https://www.tablefortwoblog.com/wp-content/uploads/2011/07/pad-see-ew-recipe-photos-tablefortwoblog-2-500x500.jpg",
#     portion_size: "24 oz container",
#     featured: true
#   },
#   {
#     name: "Panang Curry",
#     price: 10.95,
#     description: "Thai peanut curry paste, with basil, and bell pepper. Served with jasmine rice.",
#     user_id: 1,
#     image_url: "https://tastesbetterfromscratch.com/wp-content/uploads/2019/12/Panang-Curry-8.jpg",
#     portion_size: "18 oz container of curry, rice on side",
#     featured: false
#   },
# ])

# Cuisine.create([
#   {
#     name: "Vegan"
#   },
#   {
#     name: "Bakery"
#   },
#   {
#     name: "Thai"
#   }
# ])

# UserCuisine.create([
#   {
#     user_id: 1,
#     cuisine_id: 3
#   },
#   {
#     user_id: 2,
#     cuisine_id: 1
#   },
#   {
#     user_id: 2,
#     cuisine_id: 2
#   }
# ])
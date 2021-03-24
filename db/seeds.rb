User.create([
  {
    first_name: "Emmett",
    last_name: "Yang",
    email: "emmett.yang@gmail.com",
    image_url: "https://res.cloudinary.com/dbzsxlcft/image/upload/v1616610340/qs6vmwdv8cb6ldsla3we.jpg",
    password: "password",
    chef: true,
    phone: "8479626192",
    street: "#{FFaker::AddressUS.building_number} #{FFaker::AddressUS.street_name} #{FFaker::AddressUS.street_suffix}",
    city: "Chicago"
    state: "IL",
    zip_code: FFaker::AddressUS.zip_code,
    bio: "A highly acclaimed food writer and recipe developer, Emmett has penned culinary content on everything from Hawaiian cuisine to vegan sausage making."
  },
  {
    first_name: "Rebecca",
    last_name: "Young",
    email: "rebecca@gmail.com",
    image_url: "https://res.cloudinary.com/dbzsxlcft/image/upload/v1616614184/wobsfky131vs7leqt7fk.jpg",
    password: "password",
    chef: false,
    phone: "8479626192",
    street: "#{FFaker::AddressUS.building_number} #{FFaker::AddressUS.street_name} #{FFaker::AddressUS.street_suffix}",
    city: "Chicago"
    state: "IL",
    zip_code: FFaker::AddressUS.zip_code,
    bio: "I'm a full stack developer, musician, and music educator living in Chicago. My main life mission is to make the web and music accessible to all people. I play guitar in a post metal band, bass in an indie pop band, and flute in a 15 piece funk collective. I also like propogating plants, knitting, sewing, and popping pimples. "
  },
])

# Create more chefs
10.times do
  chef = HTTP.get("https://randomuser.me/api/").parse["results"][0]

  User.create({
    first_name: chef["name"]["first"],
    last_name: chef["name"]["last"],
    email: chef["email"],
    image_url: chef["picture"]["medium"],
    password: "password",
    chef: true,
    phone: "8479626192",
    street: "#{chef["location"]["street"]["number"]} #{chef["location"]["street"]["name"]}",
    city: "Chicago",
    state: "IL",
    zip_code: chef["location"]["postcode"]
  })
end

Cuisine.create([
  {
    name: "Vegan"
  },
  {
    name: "Baked Goods"
  },
  {
    name: "American"
  },
  {
    name: "Chinese"
  },
  {
    name: "Indian"
  },
  {
    name: "Mexican"
  },
  {
    name: "Gluten Free"
  },
  {
    name: "Italian"
  },
  {
    name: "Thai"
  },
  {
    name: "Soul Food"
  },
  {
    name: "Caribbean"
  },
])
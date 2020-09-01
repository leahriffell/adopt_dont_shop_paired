# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Review.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(
  name: "Rocky Mountain Puppy Rescue",
  address: "10021 E Iliff Ave",
  city: "Aurora",
  state: "CO",
  zip: "80247"
)

shelter_2 = Shelter.create!(
  name: "Espiritu Alpacas",
  address: "8221 S Blue Creek Rd",
  city: "Evergreen",
  state: "CO",
  zip: "80439"
  )

shelter_3 = Shelter.create!(
    name: "Save the Giants",
    address: "PO Box 664",
    city: "Broomfield",
    state: "CO",
    zip: "80038"
    )

shelter_4 = Shelter.create!(
    name: "Cat Care Society",
    address: "5787 W 6th Ave",
    city: "Lakewood",
    state: "CO",
    zip: "80214"
    )

review = Review.create!(
  title: "Mountains of Love <3!",
  rating: 5,
  content: "Super clean, well-facilitated, and healthy pups.",
  optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg",
  shelter_id: shelter_1.id
)

review_1 = shelter_1.reviews.create!(
  title: "Mountains of Love! <3",
  rating: 5,
  content: "Super clean, well-facilitated, and healthy pups.",
  optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg"
)

review_2 = shelter_1.reviews.create!(
  title: "meh",
  rating: 2,
  content: "it was weird."
  )

review_3 = shelter_2.reviews.create!(
  title: "Love my new friend!",
  rating: 5,
  content: "They take such good care of their doggies."
  )

review_4 = shelter_3.reviews.create!(
  title: "Stinky",
  rating: 1,
  content: "The facility smelled so bad."
  )

pet_1 = Pet.create!(
  image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
  name: "Fluffy",
  approximate_age: "15 weeks",
  sex: "Female",
  description: "I'm so fluffy.",
  adoption_status: "adoptable",
  shelter_id: shelter_1.id
)

pet_2 = Pet.create!(
  image: "https://qph.fs.quoracdn.net/main-qimg-775e3ef3258895374fcd610163d8c8e3",
  name: "Turquoise",
  approximate_age: "1 year",
  sex: "Male",
  description: "I am looking for green pastures to roam and play in.",
  adoption_status: "adoptable",
  shelter_id: shelter_1.id
)

pet_3 = Pet.create!(
  image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
  name: "Bernard",
  approximate_age: "1",
  sex: "Male",  
  description: "Ugh I'm llama. I promise I won't spit on you!",
  adoption_status: "adoptable",
  shelter_id: shelter_1.id
)

application = Application.create!(
  name: "Paul Bunyan",
  address: "12 Big Tree Ln",
  city: "Alachua",
  state: "TX",
  zip: "95743",
  phone_number: "1234567890",
  description: "My trusty Blue Ox is retired. Looking for my forever logging partner!"
)

pet_2.applications << application
pet_3.applications << application

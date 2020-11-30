Author.destroy_all
Category.destroy_all
Article.destroy_all

a = Author.create(first_name: "Maxime", last_name: "Le Segretain", email: "test@test.com", password: "test123")

Category.create(name: Faker::Cannabis.type, description: Faker::Lorem.paragraph(sentence_count: 3))
Category.create(name: Faker::Cannabis.type, description: Faker::Lorem.paragraph(sentence_count: 3))
Category.create(name: Faker::Cannabis.type, description: Faker::Lorem.paragraph(sentence_count: 3))
Category.create(name: Faker::Cannabis.type, description: Faker::Lorem.paragraph(sentence_count: 3))


20.times do 
  Article.create(title: Faker::Lorem.paragraph(sentence_count: 1), content: Faker::Lorem.paragraph(sentence_count: 20), category: Category.all.sample, author: a)
end
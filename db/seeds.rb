# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(email: 'test@email.com', password: 'password', name: 'Tom', photo: 'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-600w-542759665.jpg', bio: 'Teacher from Mexico.', confirmed_at: Time.now)
second_user = User.create(email: 'test1@email.com', password: 'password', name: 'Lilly', photo: 'https://image.shutterstock.com/image-vector/female-face-avatar-on-white-600w-562359607.jpg', bio: 'Teacher from Poland.', confirmed_at: Time.now)

first_post = Post.create(author: first_user, title: 'Hello Developers', text: 'This is first post')
second_post = Post.create(author: first_user, title: 'Morning Star', text: 'This is second post')
third_post = Post.create(author: second_user, title: 'Amazone forest', text: 'This is third post')
fourth_post = Post.create(author: second_user, title: 'Rock Music', text: 'This is fourth post')

Comment.create(post_id: first_post.id, author: second_user, text: 'I like the article about developers!' )
Comment.create(post_id: first_post.id, author: first_user, text: 'Thank you, Lilly!' )
Comment.create(post_id: second_post.id, author: second_user, text: 'Hi , this is my first comment' )
Comment.create(post_id: second_post.id, author: second_user, text: 'Hi , this is my second comment' )

Like.create(post_id: first_post.id, author: second_user)
Like.create(post_id: second_post.id, author: first_user)

puts 'Seed data loaded successfully'
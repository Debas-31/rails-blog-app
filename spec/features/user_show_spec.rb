require 'rails_helper'

RSpec.describe 'User show page test', type: :feature do
  before :each do
    User.destroy_all
    Post.destroy_all
    @user = User.create(name: 'Debas', photo: 'https://unsplash.com/6519861_z.jpg', bio: 'A web developer')
    @user.save
    @post1 = Post.create(title: 'Post 1', text: 'This is Post 1', user_id: @user.id)
    @post2 = Post.create(title: 'Post 2', text: 'This is Post 2', user_id: @user.id)
    @post3 = Post.create(title: 'Post 3', text: 'This is Post 3', user_id: @user.id)
    @post4 = Post.create(title: 'Post 4', text: 'This is Post 4', user_id: @user.id)

    visit "/users/#{@user.id}"
  end

  it 'I can see the user\'s profile picture.' do
    expect(page).to have_xpath("//img[@src = '#{@user.photo}' ]")
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content('Debas')
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content("Number of posts:#{@user.posts.count}")
    expect(page).to have_content('Number of posts:4')
  end

  it 'I can see the user\'s bio.' do
    expect(page).to have_content('A teacher')
  end

  it 'I can see the user\'s first 3 posts.' do
    expect(page).to_not have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 4')
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    expect(page).to have_button('See all posts')
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    visit "/users/#{@user.id}/posts"
    expect(page).to have_button('view post')
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    visit "/users/#{@user.id}"
    expect(page).to have_button('See all posts')
  end
end

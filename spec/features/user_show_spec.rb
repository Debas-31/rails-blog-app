require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    @user = User.create(name: 'Debas', photo: 'image_link.jpg', bio: 'Developer from Uganda')
    @post = Post.create(author: @user, title: 'My title', text: 'My text')
    (1..5).each { |i| @user.posts.create title: "Post number #{i}", text: "This is my #{i} post!" }
    @like = Like.create(author: @user, post_id: @post.id)

    visit user_path @user.id
  end

  it 'I can see the users profile picture.' do
    expect(page.find('img')['src']).to have_content 'image_link.jpg'
  end

  it 'Can see the username.' do
    expect(page).to have_content 'Debas'
  end

  it 'Can see the number of posts the user has written.' do
    expect(page).to have_content 'posts: 6'
  end

  it 'can see the users bio' do
    expect(page).to have_content 'Developer from Uganda'
  end

  it 'can see the users first 3 posts' do
    expect(page).to have_content 'Post number 5'
    expect(page).to have_content 'Post number 4'
    expect(page).to have_content 'Post number 3'
    expect(page).to have_no_content 'Post number 2'
  end

  it 'can see a button that lets me view all of a users posts.' do
    expect(page.find('a', text: 'See all posts')).to have_content 'See all posts'
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    click_on 'Post number 5'
    expect(current_path).to eq user_post_path user_id: Post.last.author.id, id: Post.last.id
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    click_on 'See all posts'
    expect(current_path).to eq user_posts_path user_id: User.last.id
  end
end

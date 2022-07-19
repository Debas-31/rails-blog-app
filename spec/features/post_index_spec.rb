require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  it 'should show the user profile picture' do
    user = User.create(name: 'Debas', photo: 'https://unsplash.com/6519861_z.jpg', bio: 'A Web developer')
    Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_css('img')
  end

  it 'should show the user name' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('John')
  end

  it 'should show the number of posts' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Post.create(title: 'Post2', text: 'Text2', user_id: user.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_content("Number of posts:#{user.posts.count}")
    expect(page).to have_content('Number of posts:2')
  end

  it 'should show the post\'s title' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Post.create(title: 'Post2', text: 'Text2', user_id: user.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('Post1')
    expect(page).to have_content('Post2')
  end

  it 'should show the post\'s body' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Post.create(title: 'Post2', text: 'Text2', user_id: user.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('Text1')
    expect(page).to have_content('Text2')
  end

  it 'should show the post\'s comments' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    user2 = User.create(name: 'Jane', photo: '', bio: 'Something')
    post1 = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Comment.create(user_id: user2.id, post_id: post1.id, text: 'Comment1')
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('Comment1')
  end

  it 'should show how many comments the post has' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    user2 = User.create(name: 'Jane', photo: '', bio: 'Something')
    post1 = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Comment.create(user_id: user2.id, post_id: post1.id, text: 'Comment1')
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('Comments: 1')
    expect(page).to have_content("Comments: #{post1.comments.count}")
  end

  it 'should show how many likes the post has' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    user2 = User.create(name: 'Jane', photo: '', bio: 'Something')
    post1 = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Like.create(user_id: user2.id, post_id: post1.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('Likes: 1')
    expect(page).to have_content("Likes: #{post1.likes.count}")
  end

  it 'should show the pagination' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Post.create(title: 'Post2', text: 'Text2', user_id: user.id)
    Post.create(title: 'Post3', text: 'Text3', user_id: user.id)
    Post.create(title: 'Post4', text: 'Text4', user_id: user.id)
    Post.create(title: 'Post5', text: 'Text5', user_id: user.id)
    visit "/users/#{user.id}/posts"

    expect(page).to have_content('Next')
    expect(page).to have_content('Previous')
    expect(page).to have_content('1')
    expect(page).to have_content('2')
    expect(page).to have_content('3')
  end

  it 'should redirect to the post page when clicking on the post title' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    post1 = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    visit "/users/#{user.id}/posts"

    click_on 'Post1'
    expect(page).to have_content('Post1')
    expect(page).to have_current_path("/users/#{user.id}/posts/#{post1.id}")
  end
end

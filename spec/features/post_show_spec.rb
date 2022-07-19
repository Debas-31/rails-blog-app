require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  it 'should show the post\'s title' do
    user = User.create(name: 'Debas', photo: 'https://unsplash.com/6519861_z.jpg', bio: 'A web developer')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('Post1')
  end

  it 'should show who wrote the post' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('by John')
  end

  it 'should show how many comments the post has' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Comment.create(text: 'Comment1', post_id: post.id, user_id: user.id)
    Comment.create(text: 'Comment2', post_id: post.id, user_id: user.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('Comments: 2')
  end

  it 'should show how many likes the post has' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Like.create(user_id: user.id, post_id: post.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('Likes: 1')
  end

  it 'should show the post\'s body' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('Text1')
  end

  it 'should show the name of the commenter' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    user2 = User.create(name: 'Jane', photo: '', bio: 'Something')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Comment.create(text: 'Comment1', post_id: post.id, user_id: user2.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('Jane:')
  end

  it 'should show the comment\'s body' do
    user = User.create(name: 'John', photo: '', bio: 'Something')
    user2 = User.create(name: 'Jane', photo: '', bio: 'Something')
    post = Post.create(title: 'Post1', text: 'Text1', user_id: user.id)
    Comment.create(text: 'Comment1', post_id: post.id, user_id: user2.id)
    visit "users/#{user.id}/posts/#{post.id}"

    expect(page).to have_content('Comment1')
  end
end

require 'rails_helper'

RSpec.describe 'Post index page test', type: :feature do
  before :each do
    User.destroy_all
    @first_user = User.create(name: 'Debas', photo: 'https://unsplash.com/6519861_z.jpg', bio: 'A web developer')
    @second_user = User.create(name: 'Tomi', photo: 'https://unsplash.com/6519861_z.jpg',
                               bio: 'A teacher from Poland')
    @first_user.save
    @second_user.save

    visit '/users'
  end

  it 'I can see the username of all other users.' do
    expect(page).to have_content('Debas')
    expect(page).to have_content('Tomi')
  end

  it 'The profile picture for each user should be visible.' do
    User.all.each do |user|
      expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
    end
  end

  it 'I can see the number of posts each user has written.' do
    User.all.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'When I click on a user, I am redirected to that users show page.' do
    click_link 'Debas'
    expect(page).to have_content('Debas')
    expect(page).to have_current_path("/users/#{@first_user.id}")
  end
end

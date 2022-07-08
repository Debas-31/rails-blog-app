require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model' do
    before(:each) do
      @user = User.new(name: 'Debas', photo: 'image_link', bio: 'full-stack Developer')
    end

    before { @user.save }

    it 'Creates an invalid user where name and posts_counter are nil' do
      invalid_user = User.create
      expect(invalid_user).to_not be_valid
    end

    it 'Creates an invalid user where posts_counter is nil' do
      invalid_user = User.create(name: 'Rob')
      expect(invalid_user).to_not be_valid
    end

    it 'Creates a valid user' do
      valid_user = User.create(name: 'Rob', posts_counter: 0)
      expect(valid_user).to be_valid
    end
  end
end

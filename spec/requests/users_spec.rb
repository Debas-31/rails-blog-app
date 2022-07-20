require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:each) do
      get '/users'
    end

    it 'GET requests response status was correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a correct template' do
      expect(response).to render_template(:index)
    end

    it 'renders content correctly' do
      expect(response.body).to include('Welcome of users page')
    end
  end

  describe 'GET #show' do
    before(:each) do
      user = User.create(name: 'Debas', photo: 'image_link', bio: 'Developer from Uganda')
      get user_path(id: user.id)
    end

    it 'GET requests response status was correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a correct template' do
      expect(response).to render_template(:show)
    end

    it 'renders content correctly' do
      expect(response.body).to include('List of recent posts')
    end
  end
end

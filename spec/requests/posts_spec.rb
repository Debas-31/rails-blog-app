require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    before(:each) do
      get '/users/0/posts'
  end

  it 'GET requests response status was correct' do
    expect(response).to have_http_status(:ok)
  end

  it 'renders a correct template' do
    expect(response).to render_template(:index)
  end

  it 'response body includes correct placeholder text' do
    expect(response.body).to include('Here is a list of posts for a given user')
end

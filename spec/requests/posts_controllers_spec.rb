require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'John Doe', photo: 'example.jpg', bio: 'Lorem ipsum') }

    before do
      user.posts.create(title: 'Post 1', text: 'Content of post 1')
      user.posts.create(title: 'Post 2', text: 'Content of post 2')
    end

    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include("Posts by #{user.name}")
      expect(response.body).to include('Post 1')
      expect(response.body).to include('Post 2')
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', photo: 'example.jpg', bio: 'Lorem ipsum') }
    let(:post) { user.posts.create(title: 'Post Title', text: 'Post Content') }

    it 'returns a successful response' do
      get user_post_path(user_id: user, id: post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(user_id: user, id: post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user_id: user, id: post)
      expect(response.body).to include("Post by #{user.name}")
      expect(response.body).to include('Post Title')
      expect(response.body).to include('Post Content')
    end
  end
end

# require 'rails_helper'

# RSpec.describe PostsController, type: :request do
#   before(:all) do
#     @user = User.create(name: 'John Doe', photo: 'sample.jpg', bio: 'A user bio')
#     @user.save # Save the user to generate an ID
#     @post = Post.create(author: @user, title: 'Sample Post', text: 'This is a sample post text')
#   end

#   # before(:all) do
#   #   @user = User.create(name: 'John Doe', photo: 'sample.jpg', bio: 'A user bio')
#   #   @post = Post.create(author: @user, title: 'Sample Post', text: 'This is a sample post text')
#   # end

#   describe 'GET #index' do
#     it 'returns a successful response' do
#       get user_posts_path(@user)
#       expect(response).to have_http_status(:success)
#     end

#     it 'renders the correct template' do
#       get user_posts_path(@user) # Use the appropriate path helper
#       expect(response).to render_template(:index)
#     end

#     it 'displays the correct placeholder text in the response body' do
#       get user_posts_path(@user) # Use the appropriate path helper
#       expect(response.body).to include('Your placeholder text')
#     end
#   end

#   # Add more test cases for other controller actions (show, create, update, etc.).
# end

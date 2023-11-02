require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: "Test User") }
  let(:post) { Post.create(title: "Sample Post") }

  describe "validations" do
    it "is valid with valid attributes" do
      like = Like.new(user: user, post: post)
      expect(like).to be_valid
    end    

    it "is not valid without a user" do
      like = Like.new(user: nil, post: post)
      expect(like).not_to be_valid
    end

    it "is not valid without a post" do
      like = Like.new(user: user, post: nil)
      expect(like).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      association = Like.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a post" do
      association = Like.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe "update_likes_counter" do
    it "updates the likes counter on the associated post" do
      post = Post.create(title: "Sample Post") # Create a new post
      like = Like.create(user: user, post: post)
  
      # Check if likes_counter is updated after creating a like
      post.reload # Refresh the post to get the updated likes_counter
      expect(post.likes_counter).to eq(1)
  
      # Create another like and check if likes_counter is updated again
      like2 = Like.create(user: user, post: post)
      post.reload # Refresh the post again
      expect(post.likes_counter).to eq(2)
    end
  end  
end

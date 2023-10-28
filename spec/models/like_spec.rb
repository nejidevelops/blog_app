require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with a user and a post' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Test Post')
    like = Like.new(user: user, post: post)
    expect(like).to be_valid
  end

  it 'is not valid without a user' do
    post = Post.create(title: 'Test Post')
    like = Like.new(post: post)
    expect(like).to be_invalid
    expect(like.errors[:user]).to include("can't be blank")
  end

  it 'is not valid without a post' do
    user = User.create(name: 'John')
    like = Like.new(user: user)
    expect(like).to be_invalid
    expect(like.errors[:post]).to include("can't be blank")
  end
end

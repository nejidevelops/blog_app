require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = user.posts.new(title: 'Hello')
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = Post.new
    expect(post).to be_invalid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is not valid if title exceeds maximum length' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = Post.new(title: 'A' * 251)
    expect(post).to be_invalid
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'is valid with a non-negative comments_counter' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = user.posts.new(title: 'Hello', comments_counter: 0)
    expect(post).to be_valid
  end

  it 'is not valid with a negative comments_counter' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = user.posts.new(title: 'Hello', comments_counter: -1)
    expect(post).to be_invalid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is valid with a non-negative likes_counter' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = user.posts.new(title: 'Hello', likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is not valid with a negative likes_counter' do
    user = User.create(name: 'Newton', posts_counter: 0)
    post = user.posts.new(title: 'Hello', likes_counter: -1)
    expect(post).to be_invalid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end
end

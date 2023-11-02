require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name' do
    user = User.new(name: 'John', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is valid with a non-negative posts_counter' do
    user = User.new(name: 'Alice', posts_counter: 0)
    expect(user).to be_valid
  end

  describe '#recent_posts' do
    it 'returns the most recent 3 posts' do
      your_class = User.new
      posts = double('posts')
      allow(your_class).to receive(:posts).and_return(posts)
      allow(posts).to receive(:limit).with(3).and_return(posts)
      allow(posts).to receive(:order).with(created_at: :desc).and_return(posts)

      expect(your_class.recent_posts).to eq(posts)
    end
  end
end

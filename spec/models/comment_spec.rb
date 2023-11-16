require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'increments comments_counter on the associated post when a new comment is created' do
    user = User.create(name: 'Bofulo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)

    expect { Comment.create(user: user, post: post, text: 'Hi Tom!') }.to change { post.reload.comments_counter }.by(1)
  end
end

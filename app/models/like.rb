class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post, foreign_key: 'post_id'

  validates :author_id, presence: true
  validates :post_id, presence: true

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

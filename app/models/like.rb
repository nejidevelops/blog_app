class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

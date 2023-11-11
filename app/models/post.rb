class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  scope :most_recent_comments, lambda { |limit = 5|
    includes(:comments).order('comments.created_at DESC').limit(limit)
  }

  def most_recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def comment_counter
    comments.count
  end

  def like_counter
    likes.count
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def validation_comments_counter
    return unless comments_counter.present? && (!comments_counter.is_a?(Integer) || comments_counter.negative?)

    errors.add(:comments_counter, 'It must be a number greater than or equal to zero') unless comments_counter.zero?
  end

  def validation_likes_counter
    return unless likes_counter.present? && (!likes_counter.is_a?(Integer) || likes_counter.negative?)

    errors.add(:likes_counter, 'It must be a number greater than or equal to zero') unless likes_counter.zero?
  end

  def initialize_comments_counter
    self.comments_counter ||= 0
  end

  def initialize_likes_counter
    self.likes_counter ||= 0
  end
end

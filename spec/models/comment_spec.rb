require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: "Test User") }
  let(:post) { Post.create(title: "Sample Post") }

  describe "validations" do
    it "is valid with valid attributes" do
      comment = Comment.new(
        author: user,
        post: post,
        text: "A valid comment",
        created_at: Time.now,
        updated_at: Time.now
      )
      expect(comment).to be_valid
    end

    it "is not valid without an author" do
      comment = Comment.new(author: nil, post: post, text: "A comment")
      expect(comment).not_to be_valid
    end

    it "is not valid without a post" do
      comment = Comment.new(author: user, post: nil, text: "A comment")
      expect(comment).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to an author (User)" do
      association = Comment.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
      expect(association.options[:foreign_key]).to eq 'author_id'
    end

    it "belongs to a post" do
      association = Comment.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end
  end
end

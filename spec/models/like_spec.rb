require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: "Test User") }
  let(:post) { Post.create(title: "Sample Post") }

  describe "validations" do
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
end

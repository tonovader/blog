require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when user has valid attributes' do
    let(:user) { FactoryBot.create :user }

    it('has name') { expect(user.name).to be_present }
    it('has email') { expect(user.email).to be_present }
    it('has password') { expect(user.password).to be_present }
  end

  context 'when user has blank attributes' do
    subject(:user) { described_class.new }

    before { user.valid? }

    it { expect(user).to be_invalid }

    it("has name can\'t be blank error") { expect(user.errors[:name]).to include 'can\'t be blank' }

    it("has email can\'t be blank error") {
      expect(user.errors[:email]).to include 'can\'t be blank'
    }

    it("has password can\'t be blank error") {
      expect(user.errors[:password]).to include 'can\'t be blank'
    }
  end

  context 'with invalid attributes' do
    subject(:user) { FactoryBot.build :user, email: 'email', password: 'password1234' }

    before { user.valid? }

    it { expect(user).to be_invalid }

    it 'has email errors' do
      expect(user.errors[:email]).not_to be_empty
    end

    it 'has password errors' do
      expect(user.errors[:password]).not_to be_empty
    end
  end
end

describe User, '#posts' do
  subject(:posts) { user.posts }

  let(:user) { FactoryBot.create :user }

  context 'when user has posts' do
    it 'returns an array of posts' do
      expect(posts).to match_array(posts)
    end
  end

  context 'when other user has posts' do
    let(:user_posts) { FactoryBot.create :posts, user: FactoryBot.create(:user) }

    it 'returns an empty array' do
      expect(posts).to be_empty
    end
  end

  context 'when user does not have any posts' do
    it 'returns an empty array' do
      expect(posts).to be_empty
    end
  end
end

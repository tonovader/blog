require 'rails_helper'

RSpec.describe User, type: :model do
  context "When user has valid attributes" do
    let(:user){FactoryBot.create :user}

    it("has name"){expect(user.name).to be_present}
    it("has email"){expect(user.email).to be_present}
    it("has password"){expect(user.password).to be_present}
  end
  context "when user has blank attributes" do
    subject(:user){described_class.new}
    before { is_expected.to be_invalid }
    it("has name can\'t be blank error") {expect(user.errors[:name]).to include 'can\'t be blank'}
    it("has email can\'t be blank error") {expect(user.errors[:email]).to include 'can\'t be blank'}
    it("has password can\'t be blank error") {expect(user.errors[:password]).to include 'can\'t be blank'}
  end

  context "when user has invalid attributes" do
    it("has email is invalid error") {expect(user.errors[:email]).to include 'is invalid error'}
    it("has password is invalid error") {expect(user.errors[:password]).to include 'is invalid error'}
  end
end
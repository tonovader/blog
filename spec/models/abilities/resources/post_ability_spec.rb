require 'rails_helper'

describe Abilities::Resources::PostAbility do
  subject(:ability) { described_class.new(user) }

  let(:user) { create :user, :sequential_user }

  context 'when post belongs to user' do
    let(:post)        { create :post, user: user }
    let(:permissions) { %i[create read delete update] }

    it 'allows user to [create read delete update] post' do
      permissions.each do |permission|
        expect(ability.can?(permission, post)).to be_truthy
      end
    end
  end

  context 'when post belongs to user but it is not saved' do
    let(:post)        { build :post, user: user }
    let(:permissions) { %i[create read delete update] }

    it 'allows user to [create read] post' do
      permissions.each do |permission|
        expect(ability.can?(permission, post)).to be_truthy
      end
    end
  end

  context 'when post does not belong to user' do
    let(:post)               { create :post }
    let(:permissions)        { %i[read] }
    let(:denied_permissions) { %i[create delete update] }

    it 'allows user to [read] post' do
      permissions.each do |permission|
        expect(ability.can?(permission, post)).to be_truthy
      end
    end

    it 'does not allow user to [create delete update] post' do
      denied_permissions.each do |permission|
        expect(ability.can?(permission, post)).to be_falsey
      end
    end
  end
end
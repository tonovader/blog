require 'rails_helper'

describe Follow, type: :model do
  context 'with valid attributes' do
    subject(:follow) { create :follow, user: antonio, recipient: tony_stark }

    let(:antonio) { create :antonio }
    let(:tony_stark) { create :tony_stark }

    it('is valid')                { expect(antonio).to be_valid }
    it('belongs to a user')       { expect(follow.user_id).to eq antonio.id }
    it('belongs to a recipient')  { expect(follow.recipient_id).to eq tony_stark.id }
  end

  context 'with empty attributes' do
    subject(:follow) { described_class.new }

    let(:antonio) { create :antonio }
    let(:tony_stark) { create :tony_stark }

    before { follow.invalid? }

    it('is invalid') { expect(follow).to be_invalid }
    it('has user must exist') { expect(follow.errors[:user]).to include 'must exist' }
    it('has user must exist ') { expect(follow.errors[:recipient]).to include 'must exist' }
  end

  context 'with repeated follows' do
    subject(:follow) { build :follow, user: antonio, recipient: tony_stark }

    let(:antonio) { create :antonio }
    let(:tony_stark) { create :tony_stark }

    before do
      create :follow, user: antonio, recipient: tony_stark
      follow.valid?
    end

    it('is invalid') { expect(follow).to be_invalid }

    it('has can not be followed twice error') {
      expect(follow.errors[:user]).to include 'can not be followed twice'
    }
  end
end

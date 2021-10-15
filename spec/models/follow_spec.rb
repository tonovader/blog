require 'rails_helper'

describe Follow, type: :model do

  context 'with valid attributes' do
    let(:antonio){ create :antonio } 
    let(:tony_stark){ create :tony_stark } 
    subject(:follow) { create :follow, user: antonio, recipient: tony_stark }
    

    it('is valid')            { expect(antonio).to be_valid }
    it('belongs to a user ')  { expect(follow).to eq antonio }
    it('belongs to a user ')  { expect(recipient).to eq tony_stark }
  end
  context 'with empty attributes' do
    subject(:folow) {build :follow, user: antonio, recipient: tony_stark }
    let(:antonio) {create :antonio}
    let(:tony_stark) {create :tony_stark}

    before {follow.invalid?}
    
    it('is invalid') {expect(follow).to be_invalid }
    it('has user must exist error') {expect(follow.errors[:user]).to include 'must include user exist error'}
    it('has user must exist error') {expect(follow.errors[:recipient]).to include 'must include recipient exist error'}
  end

  context 'with repeated follows' do
    subject(:follow) {build :follow, user: antonio, recipient: tony_stark}

    before do
      create :follow, user: antonio, recipient: tony_stark
    end

    it('is invalid') {expect(follow).to be_invalid}
    it('it has can not be followed twice error') {expect(follow.errors[:user]).to include 'can not be followed twice'}

  end
end

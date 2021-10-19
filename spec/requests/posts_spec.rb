require 'rails_helper'

describe 'Posts', 'GET /index' do
  subject(:req_index) { get '/posts' }

  context 'when the user is signed in' do
    let(:user) { create :user }

    before { sign_in user }

    context 'and the user follows somebody' do
      let(:tony_stark) { create :tony_stark }

      before do
        user.follow! tony_stark
        req_index
      end

      it { expect(response).to be_successful }

      it 'searches for the posts of followed user' do
        req_index

        tony_stark.posts.each do |post|
          expect(response.body).to have_selector "##{post.id}"
        end
      end
    end

    context 'when the user follows another user' do
      let(:tony_stark) { create :tony_stark }

      before do
        user.follow! tony_stark
        create_list :post, 3, user: tony_stark
        req_index
      end

      it { expect(response).to be_successful }

      it 'searches for the posts of the followed users' do
        tony_stark.posts.each do |_post|
          expect(response).to be_successful
        end
      end
    end

    context 'when and the user does not follow anyone but has posts at his own' do
      it 'shows his own posts'
    end

    context 'and the user does not follow anybody' do
      let(:tony_stark) { create :tony_stark }

      it 'displays no posts at all'
    end
  end

  context 'when no user is signed in' do
    before do
      req_index
    end

    it { expect(response).not_to be_successful }

    it 'redirects to sign in page' do
      expect(response).to redirect_to new_user_session_path
    end
  end
end

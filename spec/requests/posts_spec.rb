require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    context 'when the user is signed in' do
      context 'when and the user follows another user' do
        it 'searches for the posts of the followed users'
      end

      context 'when and the user does not follow anyone but has posts at his own' do
        it 'shows his own posts'
      end

      context 'when and the user does not follow anybody' do
        it 'displays no posts at all'
      end
    end

    context 'when no user is signed in' do
      it 'redirects to sign in page'
    end
  end
end

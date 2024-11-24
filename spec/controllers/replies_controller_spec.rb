require 'rails_helper'

RSpec.describe RepliesController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:reply) { create(:reply, post: post, user: user) }

  before do
    sign_in user
  end

  describe 'POST #upvote' do
    it 'creates an upvote' do
      expect {
        post :upvote, params: { id: reply.id }
      }.to change { reply.votes.count }.by(1)
    end

    it 'does not allow multiple upvotes by the same user' do
      post :upvote, params: { id: reply.id }
      post :upvote, params: { id: reply.id }
      expect(reply.votes.sum(:value)).to eq(1)
    end
  end

  describe 'POST #downvote' do
    it 'creates a downvote' do
      expect {
        post :downvote, params: { id: reply.id }
      }.to change { reply.votes.count }.by(1)
    end

    it 'does not allow multiple downvotes by the same user' do
      post :downvote, params: { id: reply.id }
      post :downvote, params: { id: reply.id }
      expect(reply.votes.sum(:value)).to eq(-1)
    end
  end
end

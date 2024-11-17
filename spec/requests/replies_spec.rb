require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/replies", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Reply. As you add validations to Reply, be sure to
  # adjust the attributes here as well.
  include Devise::Test::IntegrationHelpers

  let(:valid_attributes) {
    {
      text: "MyString",
      user_id: @user.id,
      votes: 1,
      post_id: @post.id
    }
  }
  let(:valid_attributes2) {
    {
      text: "MyString",
      user_id: @user.id
    }
  }

  before(:all) do
    @user=create(:user)
    @post=Post.create(user: @user) # creates post necessary for reply to be created
  end

  before(:each) do
    sign_in @user
  end

  after(:all) do
    @user.destroy if @user.present?
    @post.destroy if @post.present?
  end

  let(:invalid_attributes) {
    {
      text: ""
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Reply.create! valid_attributes
      get replies_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      reply = Reply.create! valid_attributes
      get reply_url(reply)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_reply_url(@post)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      reply = Reply.create! valid_attributes
      get edit_reply_url(reply)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Reply" do
        expect {
          post post_replies_path(@post), params: { reply: valid_attributes }
        }.to change(Reply, :count).by(1)
      end

      it "redirects to the created reply" do
        post post_replies_path(@post), params: { reply: valid_attributes }
        expect(response).to redirect_to(post_url(@post))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Reply" do
        expect {
          post post_replies_path(@post), params: { reply: invalid_attributes }
        }.to change(Reply, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post post_replies_path(@post), params: { reply: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          text: "Test"
        }
      }

      it "updates the requested reply" do
        reply = Reply.create! valid_attributes
        patch reply_url(reply), params: { reply: new_attributes }
        reply.reload
        expect(response).to redirect_to(@post)
        expect(reply.text).to eq("Test")
      end

      it "redirects to the post" do
        reply = Reply.create! valid_attributes
        patch reply_url(reply), params: { reply: new_attributes }
        reply.reload
        expect(response).to redirect_to(post_url(@post))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        reply = Reply.create! valid_attributes
        patch reply_url(reply), params: { reply: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested reply" do
      reply = Reply.create! valid_attributes
      expect {
        delete reply_url(reply)
      }.to change(Reply, :count).by(-1)
    end

    it "redirects to the replies list" do
      reply = Reply.create! valid_attributes
      delete reply_url(reply)
      expect(response).to redirect_to(replies_url)
    end
  end
end

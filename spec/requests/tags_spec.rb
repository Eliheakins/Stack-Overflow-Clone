

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

RSpec.describe "/tags", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Tag. As you add validations to Tag, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: "Test name",
      description: "Test description"
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Tag.create! valid_attributes
      get tags_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      tag = Tag.create! valid_attributes
      get tag_url(tag)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_tag_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      tag = Tag.create! valid_attributes
      get edit_tag_url(tag)
      expect(response).to be_successful
    end
  end

  describe "TAG /create" do
    context "with valid parameters" do
      it "creates a new Tag" do
        expect {
          post tags_url, params: { tag: valid_attributes }
        }.to change(Tag, :count).by(1)
      end

      it "redirects to the created tag" do
        post tags_url, params: { tag: valid_attributes }
        expect(response).to redirect_to(tag_url(Tag.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Tag" do
        tag = Tag.new
        expect(Tag).to receive(:new).and_return(tag)
        expect(tag).to receive(:save).and_return(nil)
        expect {
          post tags_url, params: { tag: valid_attributes }
        }.to change(Tag, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        tag = Tag.new valid_attributes
        expect(Tag).to receive(:new).and_return(tag)
        expect(tag).to receive(:save).and_return(nil)
        post tags_url, params: { tag: valid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          description: "New description"
        }
      }

      it "updates the requested tag" do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: new_attributes }
        tag.reload
        expect(tag[:description]).to eq("New description")
      end

      it "redirects to the tag" do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: new_attributes }
        tag.reload
        expect(response).to redirect_to(tag_url(tag))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        tag = Tag.new valid_attributes
        tag.save!
        expect(Tag).to receive(:find).and_return(tag)
        expect(tag).to receive(:update).and_return(nil)
        patch tag_url(tag), params: { tag: valid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested tag" do
      tag = Tag.create! valid_attributes
      expect {
        delete tag_url(tag)
      }.to change(Tag, :count).by(-1)
    end

    it "redirects to the tags list" do
      tag = Tag.create! valid_attributes
      delete tag_url(tag)
      expect(response).to redirect_to(tags_url)
    end
  end
end

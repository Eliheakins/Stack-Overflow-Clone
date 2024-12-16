require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:user) { create(:user) }
  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        text: "Text",
        user_id: user.id,
        votes: 2
      ),
      Post.create!(
        title: "Title",
        text: "Text",
        user_id: user.id,
        votes: 2
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "a.text-decoration-none.posts-card[href=?]", post_path(Post.first), count: 1
    assert_select "a.text-decoration-none.posts-card[href=?]", post_path(Post.second), count: 1

    assert_select "h5.card-title", text: Regexp.new("Title"), count: 2
    assert_select "p.card-text", text: Regexp.new("Text"), count: 2
  end
end

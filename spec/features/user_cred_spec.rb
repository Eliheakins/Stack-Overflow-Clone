require 'rails_helper'

RSpec.feature "UserCredentials", type: :feature do
  let(:user) { create(:user) }



  scenario "Certified user post should not have instructor response tag" do
    user=User.create!()
    cred = UserCred.create!(approved: true)
    expect(user).to recieve(:user_cred).and_return(cred)
    post=Post.create!(user_id: user.id)
    visit(post_path(post))
    expect(page).to_not have_content("Instructor Response")
  end

  scenario "Post with reply by certified user should have instructor response tag" do 
    poster=User.create!()
    replier = User.create!()
    cred = UserCred.create!(approved: true)
    expect(replier).to recieve(:user_cred).and_return(cred)

    post = Post.create!(user_id: poster.id)
    post.reply << Reply.create(post_id: post.id, user_id: replier.id)
    visit(post_path(post))
    expect(page).to have_content("Instructor Response")

  end
end

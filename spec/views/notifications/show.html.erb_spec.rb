require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    assign(:notification, Notification.create!(
      message: "Message",
      read: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Message/)
    expect(rendered).to match(/false/)
  end
end

require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  let(:notification) {
    Notification.create!(
      message: "MyString",
      read: false
    )
  }

  before(:each) do
    assign(:notification, notification)
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(notification), "post" do

      assert_select "input[name=?]", "notification[message]"

      assert_select "input[name=?]", "notification[read]"
    end
  end
end

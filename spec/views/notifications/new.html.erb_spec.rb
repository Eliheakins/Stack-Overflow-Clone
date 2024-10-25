require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    assign(:notification, Notification.new(
      message: "MyString",
      read: false
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do

      assert_select "input[name=?]", "notification[message]"

      assert_select "input[name=?]", "notification[read]"
    end
  end
end

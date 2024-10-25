require 'rails_helper'

RSpec.describe "notifications/index", type: :view do
  before(:each) do
    assign(:notifications, [
      Notification.create!(
        message: "Message",
        read: false
      ),
      Notification.create!(
        message: "Message",
        read: false
      )
    ])
  end

  it "renders a list of notifications" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Message".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end

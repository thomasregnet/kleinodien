require 'rails_helper'

RSpec.describe "images/index", type: :view do
  before(:each) do
    assign(:images, [
      Image.create!(
        coverartarchive_code: ""
      ),
      Image.create!(
        coverartarchive_code: ""
      )
    ])
  end

  it "renders a list of images" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
  end
end

require 'rails_helper'

RSpec.describe "release_images/new", type: :view do
  before(:each) do
    assign(:release_image, ReleaseImage.new(
      front: false,
      back: false,
      note: "MyString",
      release: nil,
      archive_org_code: 1
    ))
  end

  it "renders new release_image form" do
    render

    assert_select "form[action=?][method=?]", release_images_path, "post" do

      assert_select "input[name=?]", "release_image[front]"

      assert_select "input[name=?]", "release_image[back]"

      assert_select "input[name=?]", "release_image[note]"

      assert_select "input[name=?]", "release_image[release_id]"

      assert_select "input[name=?]", "release_image[archive_org_code]"
    end
  end
end

require 'rails_helper'

RSpec.describe "release_copies/show", type: :view do
  before(:each) do
    release_copy = FactoryBot.create(:release_copy)
    assign(:release_copy, release_copy)
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end

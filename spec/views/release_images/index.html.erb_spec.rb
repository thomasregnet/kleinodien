require 'rails_helper'

RSpec.describe "release_images/index", type: :view do
  before do
    release_images = [
      FactoryBot.create(:release_image, note: 'Note', archive_org_code: 123),
      FactoryBot.create(:release_image, note: 'Note', archive_org_code: 456)
    ]
    assign(:release_images, release_images)
  end

  it 'renders a list of release_images' do
    render
    assert_select 'tr>td', text: false.to_s, count: 4
    assert_select 'tr>td', text: 'Note'.to_s, count: 2
    assert_select 'tr>td', text: '123', count: 1
    assert_select 'tr>td', text: '456', count: 1
  end
end

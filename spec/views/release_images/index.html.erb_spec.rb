# frozen_string_literal: true

require 'rails_helper'
require 'test_data/get_empty_image_service'

RSpec.describe 'release_images/index', type: :view do
  before do
    image = TestData::GetEmptyImageService.as_io
    FactoryBot.create(:release_image, note: 'Note', coverartarchive_code: 123)
              .file.attach(io: image, filename: 'an image')
    FactoryBot.create(:release_image, note: 'Note', coverartarchive_code: 456)

    release_images = ReleaseImage.all.page
    assign(:release_images, release_images)
  end

  it 'renders a list of release_images' do
    render
    assert_select 'article', count: 1
  end
end

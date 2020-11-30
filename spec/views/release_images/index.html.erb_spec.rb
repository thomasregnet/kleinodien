# frozen_string_literal: true

require 'rails_helper'
require 'test_data/get_empty_image_service'

RSpec.describe 'release_images/index', type: :view do
  before do
    image_io = TestData::GetEmptyImageService.as_io
    image = Image.create(coverartarchive_code: 123)
    image.file.attach(io: image_io, filename: 'an image')
    FactoryBot.create(:release_image, image: image)

    FactoryBot.create(:release_image, note: 'Note', coverartarchive_code: 456)

    release_images = ReleaseImage.all.page

    assign(:release_images, release_images)
  end

  it 'renders a list of release_images' do
    render
    assert_select 'article', count: 1
  end
end

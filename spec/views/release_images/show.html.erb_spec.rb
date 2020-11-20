# frozen_string_literal: true

require 'rails_helper'
require 'test_data/get_empty_image_service'

RSpec.describe 'release_images/show', type: :view do
  let(:release_image) { FactoryBot.create(:release_image) }

  before do
    io = TestData::GetEmptyImageService.as_io
    release_image.file.attach(io: io, filename: 'an image')
    assign(:release_image, release_image)

    render
  end

  it 'shows the image' do
    expect(rendered).to match(/<img src="http/)
  end
end

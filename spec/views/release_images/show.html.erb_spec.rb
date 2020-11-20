# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_images/show', type: :view do
  let(:release_image) { FactoryBot.create(:release_image) }

  before do
    image = TestData::PathService.call(path: 'empty.jpg')
    io = StringIO.new(image)
    release_image.file.attach(io: io, filename: 'an image')
    assign(:release_image, release_image)
    
    render
  end


  it 'renders attributes in <p>' do
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Note/)
  end

  it 'shows the image' do
    expect(rendered).to match(/<img src="http/)
  end
end

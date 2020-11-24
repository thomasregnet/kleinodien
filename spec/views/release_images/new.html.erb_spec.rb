# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_images/new', type: :view do
  before do
    release_image = ReleaseImage.new(
      front_cover: false,
      back_cover:  false,
      note:        'MyString',
      release:      nil
    )
    assign(:release_image, release_image)
  end

  it 'renders new release_image form' do
    render

    assert_select 'form[action=?][method=?]', release_images_path, 'post' do
      assert_select 'input[name=?]', 'release_image[front_cover]'
      assert_select 'input[name=?]', 'release_image[back_cover]'
      assert_select 'input[name=?]', 'release_image[note]'
      assert_select 'input[name=?]', 'release_image[release_id]'
    end
  end
end

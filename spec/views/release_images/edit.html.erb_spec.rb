# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_images/edit', type: :view do
  let(:release_image) { FactoryBot.create(:release_image) }

  before { assign(:release_image, release_image) }

  it 'renders the edit release_image form' do
    render

    assert_select 'form[action=?][method=?]', release_image_path(release_image), 'post' do
      assert_select 'input[name=?]', 'release_image[front]'
      assert_select 'input[name=?]', 'release_image[back]'
      assert_select 'input[name=?]', 'release_image[note]'
      assert_select 'input[name=?]', 'release_image[release_id]'
    end
  end
end

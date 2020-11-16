# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_images/show', type: :view do
  let(:release_image) { FactoryBot.create(:release_image) }

  before { assign(:release_image, release_image) }

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Note/)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/index', type: :view do
  before do
    assign(:releases, [FactoryBot.create(:release, title: 'My Release')])
  end

  it 'displays the release title' do
    render
    expect(rendered).to match(/My Release/)
  end
end

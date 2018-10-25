# frozen_string_literal: true

require 'rails_helper'

def uri
  'https://musicbrainz.org/release/9424ad78-73f1-4148-aac5-cbff55652e22'
end

RSpec.feature 'Place import order', type: :feature do
  scenario 'User places a valid order' do
    user = FactoryBot.create(:user)
    sign_in (user)

    visit new_import_order_path

    fill_in 'Uri', with: uri
    click_button 'Submit'

    expect(page).to have_text('Successfully added your import order')
  end
end

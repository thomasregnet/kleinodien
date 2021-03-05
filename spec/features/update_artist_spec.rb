# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create an artist' do
  before do
    login_as(FactoryBot.create(:user))
    artist = FactoryBot.create(:artist)
    visit edit_artist_path(artist)
  end

  scenario 'with valid inputs' do
    fill_in 'Name', with: 'Madball'
    click_on 'Update Artist'

    expect(page).to have_content('Artist was successfully updated')
  end

  scenario 'with invalid inputs' do
    fill_in 'Name', with: ''
    click_on 'Update Artist'

    expect(page).to have_content("Name can't be blank")
  end
end

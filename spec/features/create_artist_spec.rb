# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create an artist' do
  before do
    login_as(FactoryBot.create(:user, curator: true))
    visit new_artist_path
  end

  scenario 'with valid inputs' do
    fill_in 'Name', with: 'Artist Doe'
    click_on 'Create Artist'

    expect(page).to have_content('Artist was successfully created.')
  end

  scenario 'with invalid inputs' do
    click_on 'Create Artist'

    expect(page).to have_content("Name can't be blank")
  end
end

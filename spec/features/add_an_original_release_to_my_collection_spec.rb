# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'add an OriginalRelease to my collection', type: :feature do
  let(:release) { FactoryBot.create(:release) }
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  scenario 'user adds a OriginalRelease to his collection' do
    visit release_path(release)
    click_link('Add to my collection')
    fill_in('release_copy[designation]', with: 'my designation')
    click_button('Create Release copy')

    expect(page).to have_content('Release copy was successfully created.')
  end
end
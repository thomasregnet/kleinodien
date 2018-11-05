# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'MusicBrainz imports' do
  describe 'import' do
    before(:all) do
      DatabaseCleaner.start
      BrainzImportOrder.create!(
        code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
        kind: 'release',
        state: 'pending',
        user: FactoryBot.create(:user)
      )
    end

    scenario 'import' do
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end

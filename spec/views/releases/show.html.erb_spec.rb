# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/show', type: :view do
  before do
    assign(:release, FactoryBot.create(:album))
  end

  context 'without an user' do
    it 'does not shot the Import order' do
      render
      expect(rendered).not_to match(/Import order/)
    end
  end

  context 'without an authorized user' do
    it 'does not shot the Import order' do
      assign(:user, FactoryBot.create(:user))
      render
      expect(rendered).not_to match(/Import order/)
    end
  end

  context 'with an authorized user' do
    it 'does not shot the Import order' do
      assign(:user, FactoryBot.create(:user, importer: true))
      render
      expect(rendered).not_to match(/Import order/)
    end
  end
end
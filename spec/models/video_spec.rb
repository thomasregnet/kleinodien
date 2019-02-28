# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe Video, type: :model do
  it { is_expected.to belong_to(:artist_credit).without_validating_presence }

  it_behaves_like 'a piece' do
    let(:piece) { FactoryBot.create(:video) }
  end
end

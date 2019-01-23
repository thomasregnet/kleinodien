# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe MovieRelease, type: :model do
  before(:each) do
    @movie_release = FactoryBot.create(:movie_release)
  end

  it 'is valid with valid attributes' do
    expect(@movie_release).to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { @movie_release }
  end
end

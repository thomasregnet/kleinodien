# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_formats'

RSpec.describe FormatDetail, type: :model do
  before do
    @format_detail = FactoryBot.build(:format_detail)
  end

  it_behaves_like 'a format' do
    let(:format) { @format_detail }
  end
end

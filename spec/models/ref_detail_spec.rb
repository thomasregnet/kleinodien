require 'rails_helper'
require 'shared_examples_for_formats'

RSpec.describe RefDetail, type: :model do
  it_behaves_like 'a format' do
    let(:klass) { RefDetail }
    let(:format) { RefDetail.find('FLAC') }
    let(:name) { 'FLAC' }
    let(:abbr) { 'FLAC' }
  end
end

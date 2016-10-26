require 'rails_helper'
require 'shared_examples_for_formats'

RSpec.describe RefAttribute, type: :model do
  it_behaves_like 'a format' do
    let(:klass) { RefAttribute }
    let(:format) { RefAttribute.find('FLAC') }
    let(:name) { 'FLAC' }
    let(:abbr) { 'FLAC' }
  end
end

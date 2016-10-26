require 'rails_helper'
require 'shared_examples_for_formats'

RSpec.describe ReFormat, type: :model do
  it_behaves_like 'a format' do
    let(:klass) { ReFormat }
    let(:format) { ReFormat.find('CDr') }
    let(:name) { 'CDr' }
    let(:abbr) { 'CDr' }
  end
end

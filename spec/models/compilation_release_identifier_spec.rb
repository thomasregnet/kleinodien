require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe CompilationReleaseIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryBot.build(:compilation_release_identifier) }
  end

  it 'is not valid without a CompilationRelease' do
    identifier = FactoryBot.build(:compilation_release_identifier)
    identifier.compilation_release = nil
    expect(identifier).not_to be_valid
  end
end

require 'rails_helper'

RSpec.describe Importer::Queue::Base do
  let(:base) { Importer::Queue::Base.new }
  describe '#conventions' do
    it 'returns a Importer::Queue::Conventions object' do
      expect(base.conventions).to be_instance_of(Importer::Queue::Conventions)
    end
  end
end

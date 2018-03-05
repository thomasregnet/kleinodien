require 'rails_helper'

RSpec.describe Import::Queue::Base do
  let(:base) { Import::Queue::Base.new }
  describe '#conventions' do
    it 'returns a Import::Queue::Conventions object' do
      expect(base.conventions).to be_instance_of(Import::Queue::Conventions)
    end
  end
end

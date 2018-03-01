require 'rails_helper'

RSpec.describe Fetcher::Base do
  let(:base) { Fetcher::Base.new }
  describe '#conventions' do
    it 'returns a Fetcher::Conventions object' do
      expect(base.conventions).to be_instance_of(Fetcher::Conventions)
    end
  end
end

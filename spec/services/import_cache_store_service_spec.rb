require 'rails_helper'

RSpec.describe ImportCacheStoreService do
  # it_behaves_like 'a service'

  describe '.call' do
    it 'stores data' do
      expect(described_class.call(:my_key, 'my_data')).to eq('OK')
    end
  end
end

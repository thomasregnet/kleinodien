require 'rails_helper'

RSpec.describe Duration, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'constructor' do
    context 'without accuracy' do
      before(:all) do
        @duration = Duration.new(300123)
      end

      it 'has the expected values set' do
        expect(@duration.milliseconds).to eq(300123)
        expect(@duration.accuracy).to eq('millisecond')
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

# Test initialize
class MyTestServiceInitializer < ServiceBase
  def initialize(_args); end
end

RSpec.describe ServiceBase do
  context 'when #call is not defined' do
    it 'raises an NotImplementedError' do
      expect { MyTestServiceInitializer.call(dummy: :argument) }
        .to raise_error(NotImplementedError)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

# Just for tests
class FakeImporter
end
# Just for tests
class FakeImportQueueSubscribeBase < ImportQueueSubscribeBase
  name :fake
  importer_class 'FakeImporter'
end

RSpec.describe ImportQueueSubscribeBase do
  
end

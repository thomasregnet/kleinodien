require 'rails_helper'
require 'shared_examples_for_caches'

RSpec.describe ImportCache do
  before { DatabaseCleaner.start }

  it_behaves_like 'a cache'

  after { DatabaseCleaner.clean }
end

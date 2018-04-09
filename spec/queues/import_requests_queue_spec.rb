# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_queues'

RSpec.describe ImportRequestsQueue do
  before { DatabaseCleaner.start }

  it_behaves_like 'a queue' do
    let(:object) { 'http://www.example.com' }
    let(:queue) { described_class.new(importer_name: 'test') }
  end

  after { DatabaseCleaner.clean }
end

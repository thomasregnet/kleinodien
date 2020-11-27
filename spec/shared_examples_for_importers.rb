# frozen_string_literal: true

require 'shared_examples_for_services'

RSpec.shared_examples 'an importer' do
  it_behaves_like 'a service'

  it { should respond_to(:find_existing) }
  it { should respond_to(:persist) }
  it { should respond_to(:prepare) }
end

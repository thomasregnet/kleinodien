# frozen_string_literal: true

RSpec.shared_examples 'a model having many images' do
  it { should have_many(:images) }
end

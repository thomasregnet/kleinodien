# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzArtistCredit do
  it_behaves_like 'a service'

  describe '.call' do
    it 'requests the artist' do
      proxy = instance_double('proxy')
      # expect(proxy).to have_received(:get)
    end
  end
end

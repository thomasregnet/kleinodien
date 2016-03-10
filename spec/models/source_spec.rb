require 'rails_helper'

RSpec.describe Source, type: :model do
  describe 'constants' do
    specify 'Source::Discogs' do
      expect(Source::Discogs).to be_instance_of Source
    end

    specify 'Source::MusicBrainz' do
      expect(Source::MusicBrainz).to be_instance_of Source
    end

    specify 'Source::Omdb' do
      expect(Source::Omdb).to be_instance_of Source
    end

    specify 'Source::User' do
      expect(Source::User).to be_instance_of Source
    end
  end
end

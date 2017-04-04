module Import
  # Import an album from MusicBrainz
  class BrainzRelease
    attr_reader :data

    def self.perform(data)
      new(data).perform
    end

    def initialize(data)
      multi_xml = MultiXml.parse(data)['metadata']['release']
      @data     = MashedBrainz::Release.new(multi_xml)
    end

    def perform
      artist_credit
    end

    def artist_credit
      # TODO: import the artists for ArtistCredit
      ac_name = artist_credit_name
      ac = ArtistCredit.find_by(name: ac_name)
      return ac if ac
      ArtistCredit.create!(name: ac_name)
    end

    def artist_credit_name
      # FIXME: evil hack here
      # TODO: join compound ArtistCredit names
      data.artist_credit.name_credit[0].artist.name
    end

    def artist
    end
  end
end

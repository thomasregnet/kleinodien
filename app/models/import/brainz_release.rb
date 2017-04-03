module Import
  class BrainzRelease
    attr_reader :data

    def self.perform(data)
      new(data).perform
    end

    def initialize(data)
      @data = MashedBrainz::Release.new(MultiXml.parse(data))
    end

    def perform
      data
    end
  end
end

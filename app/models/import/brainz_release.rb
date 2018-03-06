module Import
  # Takes the "code" of a MusicBrainz release to be imported
  class BrainzRelease
    include ActiveModel::Model

    attr_accessor :code
    validates :code, presence: true

    def self.perform(params)
      new(params).perform
    end

    def perform
    end
  end
end

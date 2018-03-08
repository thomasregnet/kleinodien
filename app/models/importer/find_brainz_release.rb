module Importer
  class FindBrainzRelease
    attr_reader :reference

    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      @reference = args[:reference]
    end

    def perform
      CompilationRelease.find_by(brainz_code: reference.code)
    end
  end
end

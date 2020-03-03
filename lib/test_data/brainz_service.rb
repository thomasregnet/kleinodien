# frozen_string_literal: true

require 'test_data/brainz_result'
require 'test_data/path_service'

module TestData
  # Get MusicBrainz test-data
  class BrainzService
    def self.call(args)
      new(args).call
    end

    def initialize(code:, kind:)
      @code = code
      @inc  = BRAINZ_INC_FOR[kind]
      @kind = kind.to_s.tr('_', '-')
    end

    attr_reader :code, :inc, :kind

    def call
      # BRAINZ_INC_FOR is defined in config/initializers/constants.rb
      path = "musicbrainz.org/ws/2/#{kind}/#{code}"
      path += "?#{inc}" if inc
      raw = TestData::PathService.call(path: path)
      TestData::BrainzResult.new(raw)
    end
  end
end

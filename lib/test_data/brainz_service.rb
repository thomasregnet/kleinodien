# frozen_string_literal: true

require 'test_data/brainz_result'
require 'test_data/path_service'

module TestData
  # Get MusicBrainz test-data
  class BrainzService
    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @code = args[:code]
      @kind = args[:kind]
    end

    attr_reader :code, :kind

    def call
      # BRAINZ_INC_FOR is defined in config/initializers/constants.rb
      path = "musicbrainz.org/#{kind_to_s}/#{code}?#{BRAINZ_INC_FOR[kind]}"
      raw = TestData::PathService.call(path: path)
      TestData::BrainzResult.new(raw)
    end

    def kind_to_s
      kind.to_s.tr('_', '-')
    end
  end
end

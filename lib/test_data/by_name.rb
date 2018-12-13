# frozen_string_literal: true

require 'test_data/brainz_service'

module TestData
  # Get test-data by name
  class ByName
    CLASS_AND_ARTUMENTS_FOR = {
      # TODO: remove :brainz_arise_cd
      brainz_arise_cd: {
        class_name: 'TestData::BrainzService',
        arguments: {
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
          kind: :release
        }
      },
      brainz_release_arise_jp_cd: {
        class_name: 'TestData::BrainzService',
        arguments: {
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
          kind: :release
        }
      },
      brainz_release_the_sky_is_falling_gb_cd: {
        class_name: 'TestData::BrainzService',
        arguments: {
          code: '693748be-7c18-39c3-af2e-2e62092090cf',
          kind: :release
        }
      }
    }.freeze

    def self.call(name)
      new(name).call
    end

    def initialize(name)
      @name = name
    end

    attr_reader :name

    def call
      raise ArgumentError, "can't get instructions for #{name}" \
        unless CLASS_AND_ARTUMENTS_FOR[name]

      class_name.call(arguments)
    end

    def class_name
      CLASS_AND_ARTUMENTS_FOR[name][:class_name].constantize
    end

    def arguments
      CLASS_AND_ARTUMENTS_FOR[name][:arguments]
    end
  end
end

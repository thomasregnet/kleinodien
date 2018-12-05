# frozen_string_literal: true

require 'test_data/brainz'

module TestData
  # Get test-data by name
  class ByName
    CLASS_AND_ARTUMENTS_FOR = {
      brainz_arise_cd: {
        class_name: 'TestData::Brainz',
        arguments: {
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
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

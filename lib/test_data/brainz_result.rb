# frozen_string_literal: true

require 'test_data/result_base'

module TestData
  class BrainzResult < TestData::ResultBase
    def blueprint
      BrainzBlueprint.from_xml(raw)
    end
  end
end

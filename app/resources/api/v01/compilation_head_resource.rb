# frozen_string_literal: true

module Api
  module V01
    # JSONAPI::Resources CompilationHead
    class CompilationHeadResource < JSONAPI::Resource
      immutable

      attributes :disambiguation, :title
    end
  end
end

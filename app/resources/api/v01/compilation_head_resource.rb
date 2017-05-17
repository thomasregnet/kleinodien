module Api
  module V01
    # JSONAPI::Resources CompilationHead
    class CompilationHeadResource < JSONAPI::Resource
      immutable

      attributes :disambiguation, :title
    end
  end
end

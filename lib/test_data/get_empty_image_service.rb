# frozen_string_literal: true

module TestData
  # Get an empty image
  class GetEmptyImageService
    def self.call
      PathService.call(path: 'empty.jpg')
    end

    def self.as_io
      StringIO.new(call)
    end
  end
end

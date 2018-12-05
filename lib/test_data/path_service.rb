# frozen_string_literal: true

module TestData
  # Get test-data by path
  class PathService
    FILE_EXTENSIONS = %w[.json .xml].freeze
    TEST_DATA_BASE  = 'fixtures'

    def self.get(path)
      new(path).get
    end

    def initialize(path)
      @path = path
    end

    attr_reader :path

    def get
      ['', FILE_EXTENSIONS].flatten.each do |extension|
        full_path = File.join(TEST_DATA_BASE, path) + extension
        pathname = Pathname(full_path)
        return File.open(full_path).read if pathname.file?
      end

      raise ArgumentError, "can't open #{path}"
    end
  end
end

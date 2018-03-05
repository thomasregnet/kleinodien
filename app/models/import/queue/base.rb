module Import
  module Queue
    # Base class
    class Base
      attr_reader :conventions

      def initialize(args = {})
        @conventions = Conventions.new(args)
      end
    end
  end
end

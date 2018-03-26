module ImportRequest
  extend ActiveSupport::Concern

  included do
    attr_accessor :code

    validates :code, presence: true

    define_singleton_method :importer_class do |value|
      define_method(:importer_class) { value }
    end

    define_singleton_method :reference_class do |value|
      define_method(:reference_class) { value }
    end
  end
end

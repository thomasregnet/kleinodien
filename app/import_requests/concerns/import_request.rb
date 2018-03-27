module ImportRequest
  extend ActiveSupport::Concern
  include ActiveModel::Serializers::JSON

  included do
    attr_accessor :code

    validates :code, presence: true

    define_method :class_name do
      self.class.name
    end

    define_singleton_method :importer_class do |value|
      define_method(:importer_class) { value }
    end

    define_singleton_method :reference_class do |value|
      define_method(:reference_class) { value }
    end
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end
end

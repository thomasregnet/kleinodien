module Identifyable
  extend ActiveSupport::Concern

  module ClassMethods
    def identify(source_name, value)
      identifier_class = "#{self.to_s}Identifier".constantize

      source = Source.find_by(name: source_name)
      return unless source

      identifier = identifier_class.find_by(source: source, value: value)
      return unless identifier

      return identifier.identified
    end
  end
end

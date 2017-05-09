module Identifyable
  extend ActiveSupport::Concern

  included do
    identifier_class_name = "#{self}Identifier"
    if respond_to? :identified_foreign_key
      has_many :identifiers,
               class_name: identifier_class_name,
               foreign_key: identified_foreign_key
    else
      has_many :identifiers, class_name: identifier_class_name
    end
  end

  module ClassMethods
    def identify(source_name, value)
      identifier_class = "#{self}Identifier".constantize

      source = Source.find_by(name: source_name)
      return unless source

      identifier = identifier_class.find_by(source: source, value: value)
      return unless identifier
      identifier.identified
    end
  end
end

module Identifyable
  extend ActiveSupport::Concern

  included do
    identifier_class_name = "#{self}Identifier"
    has_many :identifiers,
             class_name: identifier_class_name,
             foreign_key: ForeignKeyFinder.perform(self)
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

  # http://stackoverflow.com/questions/318850/private-module-methods-in-ruby
  class ForeignKeyFinder
    def self.perform(klass)
      klass.ancestors.each do |ancestor|
        next unless ancestor.respond_to? :superclass
        if ancestor.superclass == ActiveRecord::Base
          return ancestor.to_s.foreign_key.to_sym
        end
      end
    end
  end
end

module Identifyable
  extend ActiveSupport::Concern

  module ClassMethods
    def identify(source, value)
      nil
    end
  end
end

# frozen_string_literal: true

# Extends models with the .find_by_code class-method
module CodeFindable
  extend ActiveSupport::Concern

  # Class-methods of CodeFindable
  module ClassMethods
    def find_by_codes(codes_hash)
      model_class = model_name.name.constantize

      FindByCodesService.call(
        model_class: model_class,
        codes_hash:  codes_hash
      )
    end
  end
end

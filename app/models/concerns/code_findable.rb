module CodeFindable
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_codes(attributes)
      model_class = model_name.name.constantize

      FindByCodesService.call(
        model_class: model_class,
        attributes:  attributes
      )
    end
  end
end

# frozen_string_literal: true

# Validate if the code-attribute is an UUID
module CodeUuidValidation
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    validates :code,
              format: {
                with: /
                  \A
                  [a-z0-9]{8}
                  -
                  [a-z0-9]{4}
                  -
                  [a-z0-9]{4}
                  -
                  [a-z0-9]{4}
                  -
                  [a-z0-9]{12}
                  \z
                /x,
                message: 'must be an uuid'
              }
  end
end

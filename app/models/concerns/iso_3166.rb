# frozen_string_literal: true

# Common stuff for all ISO3166Part?Country models
module Iso3166
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    # validates :code, blank: false, presence: { message: "code can't be blank" }
    validates :code, presence: true
  end
end

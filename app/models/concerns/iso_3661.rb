# frozen_string_literal: true


module Iso3661
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    validates :code, blank: false, presence: true
  end
end

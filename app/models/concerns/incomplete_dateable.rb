# frozen_string_literal: true

module IncompleteDateable
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    composed_of(
      :date,
      class_name: 'IncompleteDate',
      allow_nil:  true,
      mapping:    [%w[date_year year], %w[date_month month], %w[date_day day]]
    )

    validate :date_must_be_valid
  end

  private

  def date_must_be_valid
    return unless date

    errors.add :date, 'date is not valid' unless date.valid?
  end
end

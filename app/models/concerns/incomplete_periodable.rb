# frozen_string_literal: true

module IncompletePeriodable
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    composed_of(
      :begin_date,
      allow_nil:  true,
      class_name: 'IncompleteDate',
      mapping:    [%w[begin_date_year year], %(begin_date_month month), %w[begin_date_day day]]
    )
    composed_of(
      :end_date,
      allow_nil:  true,
      class_name: 'IncompleteDate',
      mapping:    [%w[end_date_year year], %(end_date_month month), %w[end_date_day day]]
    )

    validate :validate_period

    private

    def validate_period
      errors.add :begin_date, 'begin_date is invalid' if begin_date && !begin_date.valid?
      errors.add :end_date, 'end_date is invalid' if end_date && !end_date.valid?

      return unless begin_date && end_date

      errors.add :base, 'begin_date is newer than end_date' if begin_date > end_date
    end
  end
end

# frozen_string_literal: true

# To be included in models using begin_date and end_date
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

    validate :period_must_be_valid
  end

  private

  def period_must_be_valid
    date_must_be_valid(:begin, begin_date)
    date_must_be_valid(:end, end_date)
    begin_date_must_not_be_newer_than_end_date
  end

  def date_must_be_valid(what_date, date)
    return unless date

    errors.add what_date, "#{what_date} is not valid" unless date.valid?
  end

  def begin_date_must_not_be_newer_than_end_date
    return unless begin_date&.any? && end_date&.any?

    errors.add :base, 'begin_date is newer than end_date' if begin_date > end_date
  end
end

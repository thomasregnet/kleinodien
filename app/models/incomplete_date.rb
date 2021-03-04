# frozen_string_literal: true

require 'date'

# Representation of a date which must not consist of all
# parameters year, month and day.
class IncompleteDate < Delegator
  VALID_MASKS = [4, 6, 7].freeze

  attr_reader :date, :mask

  def self.from_string(date_string)
    digits = date_string.split('-').map(&:to_i)
    mask   = [4, 6, 7].fetch(digits.length - 1)
    date   = Date.new(*digits)
    new(date, mask)
  end

  # rubocop:disable Lint/MissingSuper
  def initialize(date, mask)
    raise(ArgumentError, "invalid mask: #{mask}") \
      unless VALID_MASKS.include?(mask)

    @date = date
    @mask = mask
  end
  # rubocop:enable Lint/MissingSuper

  def to_s
    case mask
    when 4
      year.to_s
    when 6
      strftime('%Y-%m')
    when 7
      strftime('%F')
    else
      raise "invalid mask: #{mask}"
    end
  end

  def __getobj__
    date
  end
end

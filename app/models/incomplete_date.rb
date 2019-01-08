# frozen_string_literal: true

require 'date'

# Representation of a date which must not consist of all
# parameters year, month and day.
class IncompleteDate < Delegator
  attr_reader :date, :mask

  def self.from_string(date_string)
    digits = date_string.split('-').map(&:to_i)
    mask   = [4, 6, 7].fetch(digits.length - 1)
    date   = Date.new(*digits)
    new(date, mask)
  end

  def initialize(date, mask)
    @date = date
    @mask = mask
  end

  def __getobj__
    date
  end
end

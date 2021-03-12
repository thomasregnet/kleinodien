# frozen_string_literal: true

require 'date'

# Representation of a date which must not consist of all
# parameters year, month and day.
# class IncompleteDate < Delegator
class IncompleteDate
  include Comparable

  def self.from_string(date_string)
    year, month, day = date_string.split('-').map(&:to_i)
    new(year, month, day)
  end

  def initialize(year = nil, month = nil, day = nil)
    init_date(year, month, day)

    @year  = year
    @month = month
    @day   = day
  rescue Date::Error => e
    Rails.logger.error("Bad value for IncompleteDate: #{e.message}")
  rescue TypeError => e
    Rails.logger.error("IncompleteDate TypeError: #{e.message}")
  end

  attr_reader :year, :month, :day

  def <=>(other)
    rank = comparable_rank(other)
    year_month_day[0..rank] <=> other.year_month_day[0..rank] 
  end

  def accuracy
    return unless year

    return :day if day
    return :month if month

    :year
  end

  def any?
    year_month_day.compact.any?
  end

  def to_s
    return unless year

    case accuracy
    when :year
      year.to_s
    when :month
      date.strftime('%Y-%m')
    else
      date.strftime('%F')
    end
  end

  def valid?
    date ? true : false
  end

  def year_month_day
    [year, month, day]
  end

  private

  attr_reader :date

  def init_date(year, month, day)
    raise Date::Error, 'if day is set month needs a value' if day && !month
    raise Date::Error, 'if month is set year needs a value' if month && !year

    @date = date_for(year, month, day)
  end

  def date_for(year, month, day)
    Date.new(year || 1, month || 1, day || 1)
  end

  def comparable_rank(other)
    return 2 if day   && other.day
    return 1 if month && other.month
    return 0 if year  && other.year
  end
end

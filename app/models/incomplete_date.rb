class IncompleteDate
  include Comparable
  include DateAccuracy

  STRING_ACCURACY = {1 => :year, 2 => :month, 3 => :day}

  def self.from_string(string)
    accuracy = string.strip.split("-")
      .then { |yyyymmdd| yyyymmdd.length }
      .then { |length| STRING_ACCURACY[length] }

    # a string only representing a year (eg. "2025") raises Date::Error
    # a string representing year and month (eg "2024-01") is ok
    string = "#{string}-01" if accuracy == :year
    new(string, accuracy)
  end

  def initialize(date, accuracy)
    date = Date.iso8601(date) if date.is_a? String
    @date = date

    if accuracy.present? && DATE_ACCURACY_VALUES.exclude?(accuracy)
      raise ArgumentError, "invalid accuracy #{accuracy}"
    end

    @accuracy = accuracy
  end

  attr_reader :accuracy, :date

  # accuracy is ignored in comparsion
  def <=>(other)
    date <=> other.date
  end

  def year
    date&.year
  end

  def month
    date&.month
  end

  def day
    date&.day
  end

  private

  def init_accuracy(date_string)
    @accuracy = string.strip.split("-")
      .then { |yyyymmdd| yyyymmdd.length }
      .then { |length| STRING_ACCURACY[length] }
  end
end

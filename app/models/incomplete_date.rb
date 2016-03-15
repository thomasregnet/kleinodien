# IncompleteDate represents a date which must not consist of all
# obvious parameters year, month and day.
class IncompleteDate < KleinodienDateTime::IncompleteDate
  # attr_reader :date, :mask
  def initialize(parameter, mask = 7)
    if parameter.instance_of?(Date)
      @date = parameter
      @mask = mask
    else
      @string = parameter.to_s
      date = @string.split('-').map(&:to_i)
      @mask = [4, 6, 7].fetch(date.length - 1)
      @date = Date.new(*date)
    end

    # if mask
    #   @mask = mask
    # end
  end

  def to_s
    date.to_s
  end
  # def initialize(date, mask = nil)
  #   init_date(date)
  #   if mask
  #     @mask = mask
  #   else
  #     init_mask(date)
  #   end
  # end

  # def date_from_string(string)
  #   return Date.iso8601(string) if /^\d\d\d\d-\d\d-\d\d$/.match(string)
  #   return Date.iso8601(string + '-01') if /^\d\d\d\d-\d\d$/.match(string)
  #   return Date.iso8601(string + '-01-01') if /^\d\d\d\d$/.match(string)
  #   nil
  # end

  # def mask_from_string(string)
  #   return 7 if /\d\d\d\d-\d\d-\d\d/.match(string)
  #   return 6 if /^\d\d\d\d-\d\d$/.match(string)
  #   return 4 if /^\d\d\d\d$/.match(string)
  #   nil
  # end

  # def to_s
  #   @date.to_s
  # end

  # private

  # def init_date(date)
  #   case date.class.to_s
  #   when 'Date'
  #     @date = date
  #   when 'Fixnum'
  #     @date = Date.new(date, 1, 1)
  #   when 'String'
  #     @date = date_from_string(date)
  #   end
  # end

  # def init_mask(date)
  #   case date.class.to_s
  #   when 'Date'
  #     @mask = 7
  #   when 'Fixnum'
  #     @mask = 4
  #   when 'String'
  #     @mask = mask_from_string(date)
  #   end
  # end
end

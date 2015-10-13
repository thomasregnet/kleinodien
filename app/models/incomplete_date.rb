class IncompleteDate
  attr_reader :date, :mask

  def initialize(date, mask=nil)
    init_date(date)
    if mask
      @mask = mask
    else
      init_mask(date)
    end
  end 

  def date_from_string(string)
    return Date.iso8601(string) if /^\d\d\d\d-\d\d-\d\d$/.match(string)
    return Date.iso8601(string + '-01') if /^\d\d\d\d-\d\d$/.match(string)
    return Date.iso8601(string + '-01-01') if /^\d\d\d\d$/.match(string)
    nil
  end

  def mask_from_string(string)
    return 7 if /\d\d\d\d-\d\d-\d\d/.match(string)
    return 6 if /^\d\d\d\d-\d\d$/.match(string)
    return 4 if /^\d\d\d\d$/.match(string)
    nil
  end

  def to_s
    @date.to_s
  end
  
  private

  def init_date(date)
    if date.class == Date
      @date = date
    elsif date.class == Fixnum
      @date = Date.new(date, 1, 1)
    elsif date.class == String
      @date = date_from_string(date)
    end
  end

  def init_mask(date)
    if date.class == Date
      @mask = 7
    elsif date.class == Fixnum
      @mask = 4
    elsif date.class == String
      @mask = mask_from_string(date)
    end
  end
end

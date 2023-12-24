module Import
  class Json
    def self.parse(*)
      new(*).parse
    end

    def initialize(json_string)
      @json_string = json_string
    end

    def parse
      transform(raw_data)
    end

    private

    attr_reader :json_string

    # def transform(given)
    #   return transform_array(given) if given.is_a? Array
    #   return transform_hash(given) if given.is_a? Hash

    #   given
    # end

    def transform(given)
      case given.class.name
      when "Array"
        transform_array(given)
      when "Hash"
        transform_hash(given)
      else
        given
      end
    end

    def transform_array(values)
      values.map { |value| transform(value) }
    end

    def transform_hash(hash)
      hash.transform_keys!(&:underscore)
      hash.transform_values! { |value| transform(value) }

      OpenStruct.new(hash)
    end

    def raw_data
      @raw_data ||= JSON.parse(json_string)
    end
  end
end

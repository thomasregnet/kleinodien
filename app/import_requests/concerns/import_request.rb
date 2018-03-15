module ImportRequest
  extend ActiveSupport::Concern

  included do
    define_singleton_method :prefix do |value|
      define_method(:prefix) { value }
    end
  end

  def requests_key
    "#{prefix}:requests"
  end

  def uris_key
    "#{prefix}:uris"
  end
end

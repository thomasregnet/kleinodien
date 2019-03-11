# frozen_string_literal: true

# Base for service-classes
class ServiceBase
  def self.call(args)
    new(args).call
  end

  def call
    raise NotImplementedError, "#{self.class} does not implement #call"
  end
end

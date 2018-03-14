module QueueRequest
  extend ActiveSupport::Concern

  def queue_name_for(prefix)
    "#{prefix}:queue"
  end
end

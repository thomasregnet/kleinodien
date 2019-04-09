# frozen_string_literal: true

# Base class for import-workers
class ImportWorkerBase
  def run
    unsubscribe
  end

  def unsubscribe
  end
end

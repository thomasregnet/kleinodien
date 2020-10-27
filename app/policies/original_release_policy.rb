# frozen_string_literal: true

class OriginalReleasePolicy < ReleaseCopyPolicy
  class Scope < Scope
    def create?
      true
    end
  end
end

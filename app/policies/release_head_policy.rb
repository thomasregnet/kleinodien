# frozen_string_literal: treu

# Policies for release_heads
class ReleaseHeadPolicy < CuratorPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

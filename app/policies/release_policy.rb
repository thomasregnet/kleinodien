# frozen_string_literal: treu

# Policies for releases
class ReleasePolicy < CuratorPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

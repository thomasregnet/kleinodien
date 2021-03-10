# frozen_string_literal: treu

# Policies for artist
class ArtistPolicy < CuratorPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

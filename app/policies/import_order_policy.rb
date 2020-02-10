# frozen_string_literal: true

class ImportOrderPolicy < ApplicationPolicy
  def create?
    user.importer?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

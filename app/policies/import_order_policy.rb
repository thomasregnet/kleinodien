# frozen_string_literal: true

class ImportOrderPolicy < ApplicationPolicy
  def create?
    user.importer?
  end

  def destroy?
    user.importer?
  end

  def edit?
    user.importer?
  end

  def index?
    user.importer?
  end

  def show?
    user.importer?
  end

  def update?
    user.importer?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

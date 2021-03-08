# frozen_string_literal: true

# A curator is allowed to create and edit common resources
class CuratorPolicy < ApplicationPolicy
  def create?
    user.curator?
  end

  def destroy?
    user.curator?
  end

  def edit?
    user.curator?
  end

  def update?
    user.curator?
  end

  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
end

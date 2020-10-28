# frozen_string_literal: true

class ReleaseCopyPolicy < ApplicationPolicy
  def create?
    user ? true : false
  end

  def index?
    user ? true: false
  end

  class Scope < Scope
  end
end

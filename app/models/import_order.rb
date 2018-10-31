# frozen_string_literal: true

# Queue users orders of metadata imports
class ImportOrder < ApplicationRecord
  belongs_to :user

  after_initialize :set_default_state

  validates :code, :kind, :user, presence: true

  private

  def set_default_state
    return if state

    self.state = 'placed'
  end
end

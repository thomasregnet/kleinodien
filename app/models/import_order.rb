# frozen_string_literal: true

# Queue users orders of metadata imports
class ImportOrder < ApplicationRecord
  belongs_to :user
  has_many :heap_heads
  has_many :heap_tracks
  has_many :heaps
  has_many :import_requests
  has_many :pieces

  after_initialize :set_default_state

  validates :code, :kind, :state, :user, presence: true
  validates :state, inclusion: { in: %w[pending processing done failed] }

  private

  def set_default_state
    return if state

    self.state = 'pending'
  end
end

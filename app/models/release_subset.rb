# frozen_string_literal: true

class ReleaseSubset < ApplicationRecord
  belongs_to :release

  has_many :tracks, class_name: 'ReleaseTrack'

  validates :no, presence: true, blank: false
end

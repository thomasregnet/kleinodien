# frozen_string_literal: true

# A single track, not belonging to an Compilation
class PieceTrack < ApplicationRecord
  belongs_to :piece
  belongs_to :tr_format_kinds,
             required: false

  composed_of :duration,
              class_name: 'Duration',
              mapping:    [%w[milliseconds milliseconds], %w[accuracy accuracy]]

  # TODO: relation to formats and format details
end

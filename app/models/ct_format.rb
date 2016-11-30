# CompilationTrackFormat
class CtFormat < ApplicationRecord
  belongs_to :format, foreign_key: :name
  delegate :abbr, to: :format
end

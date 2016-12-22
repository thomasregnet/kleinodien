# CompilationTrack format detail
class CtFormatDetail < ApplicationRecord
  belongs_to :compilation_track, inverse_of: :format_details
  belongs_to :detail,
             class_name: FormatDetail,
             primary_key: :abbr,
             foreign_key: :abbr
end

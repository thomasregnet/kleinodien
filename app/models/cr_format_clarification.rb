class CrFormatClarification < ActiveRecord::Base
  belongs_to :format, class_name: CrFormat, foreign_key: :cr_format_id
  belongs_to :format_kind
end

class RepositoryFormatDetail < ApplicationRecord
  belongs_to :repository, inverse_of: :format_details
  belongs_to :detail, class_name: FormatDetail, foreign_key: :format_detail_id
end

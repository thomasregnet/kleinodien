class RepositoryFormatDetail < ApplicationRecord
  belongs_to :repository, inverse_of: :format_details
end

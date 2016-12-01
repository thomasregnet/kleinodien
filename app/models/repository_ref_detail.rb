# Repository Repository Format Detail
class RepositoryRefDetail < ApplicationRecord
  self.primary_key = [:name, :repository_id, :no]

  belongs_to :detail,
             class_name: RefDetail,
             primary_key: :name,
             foreign_key: :name
  belongs_to :repository

  delegate :abbr, to: :detail
end

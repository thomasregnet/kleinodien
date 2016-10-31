class Repository < ApplicationRecord
  belongs_to :format,
             class_name: ReFormat,
             primary_key: :name,
             foreign_key: :format_name
  belongs_to :user
  has_many :format_details,
           class_name: RepositoryRefDetail
  
  validates :name, presence: true
  validates :user, presence: true
end

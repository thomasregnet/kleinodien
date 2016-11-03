class Repository < ApplicationRecord
  belongs_to :format,
             class_name: ReFormat,
             primary_key: :name,
             foreign_key: :format_name
  belongs_to :user
  has_many :format_details,
           class_name: RepositoryRefDetail

  accepts_nested_attributes_for :format_details
  
  validates :name, presence: true
  validates :user, presence: true

  # def all_format_details(detail_names = [])
  #   byebug
  # end
end

# A Repository is used to store parts of an users collection
class Repository < ApplicationRecord
  belongs_to :format, required: false
  belongs_to :user

  has_many :comments
  has_many :format_details,
           class_name: RepositoryFormatDetail

  # TODO: check if accepts_nested_attributes_for :format_details is needed
  accepts_nested_attributes_for :format_details

  validates :name, presence: true
  validates :user, presence: true
end

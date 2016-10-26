class Repository < ApplicationRecord
  belongs_to :format,
             class_name: ReFormat,
             primary_key: :name,
             foreign_key: :re_format_name
  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true
end

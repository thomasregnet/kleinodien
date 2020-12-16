# frozen_string_literal: true

# A PieceHead my be a song, movie ...
class PieceHead < ActiveRecord::Base
  include CodeFindable

  belongs_to :import_order, required: false
  has_and_belongs_to_many :tags
  has_many :companies, class_name: 'PhCompany'
  has_many :labels, class_name: 'PhLabel'
  has_many :ratings

  validates(
    :title,
    presence:   { message: "title can't be blank" },
    uniqueness: {
      scope:          %i[type disambiguation artist_credit_id],
      case_sensitive: false
    }
  )
  validates :type, presence: { message: "type can't be blank" }
end

# frozen_string_literal: true

# An image of a Release
class ReleaseImage < ApplicationRecord
  include ImageAttachable

  belongs_to :image
  belongs_to :import_order, required: false
  belongs_to :release

  has_and_belongs_to_many :tags, class_name: 'ImageTag'
end

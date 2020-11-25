# frozen_string_literal: true

# An image of a Release
class ReleaseImage < ApplicationRecord
  include ImageAttachable

  belongs_to :image
  belongs_to :import_order, required: false
  belongs_to :release

  has_and_belongs_to_many :tags, join_table: :image_tags_release_images, association_foreign_key: :image_tag_id
end

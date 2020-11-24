# frozen_string_literal: true

# Image
class Image < ApplicationRecord
  include FileAttachable

  belongs_to :import_order, optional: true
end

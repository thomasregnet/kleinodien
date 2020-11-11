# frozen_string_literal: true

# An image of a Release
class ReleaseImage < ApplicationRecord
  include FileAttachable

  belongs_to :release
end

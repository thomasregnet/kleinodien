# frozen_string_literal: true

# An image of a Release
class ReleaseImage < ApplicationRecord
  include ImageAttachable

  belongs_to :release
end

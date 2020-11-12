# frozen_string_literal: true

# has_one_attached file
# https://stackoverflow.com/questions/49510195/rails-5-2-active-storage-add-custom-attributes
module ImageAttachable
  extend ActiveSupport::Concern
  include FileAttachable

  included do
    validate :either_front_or_back
  end

  private

  def either_front_or_back
    return unless front && back

    errors.add(:base, 'can be eigther front or back, not both')
  end
end

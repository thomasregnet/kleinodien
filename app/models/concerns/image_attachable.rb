# frozen_string_literal: true

# has_one_attached file
# https://stackoverflow.com/questions/49510195/rails-5-2-active-storage-add-custom-attributes
module ImageAttachable
  extend ActiveSupport::Concern
  include FileAttachable

  included do
    delegate_missing_to :image
    validate :either_front_or_back
  end

  # delegate_missing_to seems not to work proper wit file so we implement it "by hand"
  def file
    image&.file
  end

  private

  def either_front_or_back
    return unless front_cover && back_cover

    errors.add(:base, 'can be either front_back or back_cover, not both')
  end
end

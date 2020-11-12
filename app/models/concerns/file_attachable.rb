# frozen_string_literal: true

# has_one_attached file
# https://stackoverflow.com/questions/49510195/rails-5-2-active-storage-add-custom-attributes
module FileAttachable
  extend ActiveSupport::Concern

  included do
    has_one_attached :file
    delegate_missing_to :file

    validate :either_front_or_back
  end

  private

  def either_front_or_back
    return unless front && back

    errors.add(:base, 'can be eigther front or back, not both')
  end
end

# frozen_string_literal: true

module ApplicationHelper
  def title
    content_for(:title) || 'Kleinodien'
  end
end

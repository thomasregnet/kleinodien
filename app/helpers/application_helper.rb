# frozen_string_literal: true

module ApplicationHelper
  def title
    content_for(:title) || 'Foo'
  end
end

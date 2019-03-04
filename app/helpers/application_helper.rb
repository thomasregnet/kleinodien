module ApplicationHelper
  def title
    content_for(:title) || 'Foo'
  end
end

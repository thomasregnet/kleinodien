# frozen_string_literal: true

module ImportOrdersHelper
  def import_order_state_class_for(state)
    return 'tag is-dark' if state == 'pending'
    return 'tag is-primary is-light' if state == 'preparing'
    return 'tag is-primary' if state == 'persisting'
    return 'tag is-success' if state == 'done'

    'tag is-danger'
  end
end

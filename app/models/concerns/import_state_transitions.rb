# frozen_string_literal: true

# Transits from "pending" to "running" and then to "done" or "failed"
module ImportStateTransitions
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :state do
      state :pending, initial: true
      state :running, :done, :failed

      after_all_transitions { save! }

      event :run do
        transitions from: :pending, to: :running
      end

      event :done do
        transitions from: :running, to: :done
      end

      event :failure do
        transitions from: %i[pending running], to: :failed
      end
    end
  end
end

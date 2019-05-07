# frozen_string_literal: true

# Transits from "pending" to "processing" and then to "done" or "failed"
module ImportStateTransitions
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :state do
      state :pending, initial: true
      state :processing, :done, :failed

      event :process do
        transitions from: :pending, to: :processing
      end

      event :done do
        transitions from: :processing, to: :done
      end

      event :failure do
        transitions from: :processing, to: :failed
      end
    end
  end
end

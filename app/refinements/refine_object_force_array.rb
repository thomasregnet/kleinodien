# frozen_string_literal: true

# Return an array with the receiver as the only item unless the
# the object itself is an array
module RefineObjectForceArray
  refine Object do
    def force_array
      return self if is_a? Array

      [self]
    end
  end
end

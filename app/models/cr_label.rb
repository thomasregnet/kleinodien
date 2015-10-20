class CrLabel < ActiveRecord::Base
  belongs_to :compilation_release
  belongs_to :company
end

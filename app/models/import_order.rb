# frozen_string_literal: true

# Queue users orders of metadata imports
class ImportOrder < ApplicationRecord
  belongs_to :user

  after_initialize :set_default_state
  after_initialize :try_to_assign_missing_params

  private

  def set_default_state
    return if state

    self.state = 'placed'
  end

  def try_to_assign_missing_params
    return if !uri || code || kind || type

    params = ExtractImportOrderParamsService.call(uri)
    self.code = params[:code]
    self.kind = params[:kind]
    self.type = params[:type]
  end
end

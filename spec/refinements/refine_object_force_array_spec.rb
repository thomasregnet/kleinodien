# frozen_string_literal: true

require 'rails_helper'

# For testing
class TestRefineObjectForceArray
  using RefineObjectForceArray

  def initialize(gizmo)
    @gizmo = gizmo
  end

  attr_reader :gizmo

  def gizmo_force_array
    gizmo.force_array
  end
end

RSpec.describe RefineObjectForceArray do
  context 'with a string' do
    let(:refiner) { TestRefineObjectForceArray.new('Hello') }

    it 'returns an array with the string as first item' do
      expect(refiner.gizmo_force_array[0]).to eq('Hello')
    end

    it 'returns an array with one item' do
      expect(refiner.gizmo_force_array.length).to eq(1)
    end
  end

  context 'with an array' do
    let(:array) { ['item'] }
    let(:refiner) { TestRefineObjectForceArray.new(array) }

    it 'returns that array' do
      expect(refiner.gizmo_force_array.object_id).to eq(array.object_id)
    end
  end
end

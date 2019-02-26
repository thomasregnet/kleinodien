# frozen_string_literal: true

# Controller for Heaps, Albums, Singles...
class HeapsController < ApplicationController
  def index
    @heaps = Heap.all
  end

  def show
    @heap = Heap.find(params[:id])
  end
end

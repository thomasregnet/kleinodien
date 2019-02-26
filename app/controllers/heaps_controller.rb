class HeapsController < ApplicationController
  def index
    @heaps = Heap.all
  end

  def show
  end
end

class CompilationCopiesController < ApplicationController

  def create
  end
  def new
    @copy = CompilationCopy.new
    @compilation_release_id = compilation_copie_parms
    @repositories = Repository.where(user: current_user)
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def compilation_copie_parms
    params.require(:compilation_release_id)
  end
end

# Controller for CompilationCopies
class CompilationCopiesController < ApplicationController
  def create
    @compilation_copy = CompilationCopy.new(create_compilation_release_params)
    @compilation_copy.user = current_user

    if @compilation_copy.save
      redirect_to @compilation_copy
    else
      render :new
    end
  end

  def new
    @compilation_copy = CompilationCopy.new
    @compilation_release_id = compilation_copie_parms
    @repositories = Repository.where(user: current_user)
  end

  def index
  end

  def show
    @compilation_copy = CompilationCopy.find(params[:id])
  end

  def edit
  end

  private

  def compilation_copie_parms
    params.require(:compilation_release_id)
  end

  def create_compilation_release_params
    params.require(:compilation_copy).permit(
      :compilation_release_id, :note, repositories: []
    )
  end
end

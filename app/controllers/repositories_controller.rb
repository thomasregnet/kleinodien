class RepositoriesController < ApplicationController
  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(repository_params)
    @repository.user = current_user
    logger.debug "current_user: #{current_user.email}"
    if @repository.save!
      redirect_to @repository
    else
      render 'new'
    end
  end

  def show
    @repository = Repository.find(params[:id])
    #render @repository
  end

  def index
  end

  #private

  def repository_params
    logger.debug "==================="
    x = params.require(:repository).permit(:name)
    logger.debug "===================Z #{x}"
    params.require(:repository).permit(:name, :id)
  end
end

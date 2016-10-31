class RepositoriesController < ApplicationController
  def new
    # TODO: new needs valid user
    @repository = Repository.new
    @formats = ReFormat.all
  end

  def create
    @repository = Repository.new(repository_params)
    @repository.user = current_user
    if @repository.save!
      redirect_to @repository
    else
      render 'new'
    end
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def index
    @repositories = Repository.where(user: current_user)
  end

  private

  def repository_params
    params.require(:repository).permit(:name, :id, :re_format_name)
  end
end

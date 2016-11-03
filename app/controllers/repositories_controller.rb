class RepositoriesController < ApplicationController
  def new
    # TODO: new needs valid user
    @repository     = Repository.new
    @formats        = ReFormat.all
    @format_details = RefDetail.all
  end

  def create

    params = repository_params
    format_detail_names = params.delete(:format_details)
    # byebug
    @repository = Repository.new(params)
    detail_names = format_detail_names.select { |name| !name.blank? }
    detail_names.each_with_index do |name, no|
      
      #RepositoryRefDetail.create(name: name, no: no,
      @repository.format_details.build(name: name, no: no)
    end
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
    params.require(:repository).permit(
      :name, :id, :format_name, format_details: []
    )
  end
end

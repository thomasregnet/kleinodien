class OriginalExemplarsController < ApplicationController
  def new
    @original_exemplar      = OriginalExemplar.new
    @compilation_release_id = params[:compilation_release_id]
  end

  def create
    @original_exemplar = OriginalExemplar.new(original_exemplar_params)
    @original_exemplar.user = current_user

    if @original_exemplar.save
      redirect_to @original_exemplar
    else
      render :new
    end
  end

  def update; end

  def edit; end

  def destroy; end

  def index; end

  def show
    @original_exemplar = OriginalExemplar.find(params[:id])
  end

  private

  def original_exemplar_params
    params.require(:original_exemplar)
          .permit(:compilation_release_id, :disambiguation)
  end
end

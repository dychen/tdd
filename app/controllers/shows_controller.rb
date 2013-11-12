class ShowsController < ApplicationController
  def index
    @shows = Show.all
  end

  def new
    @show = Show.new
  end

  def create
    show_params = params.require(:show).permit(:name, :picture)
    @show = Show.new(show_params)
    @success = @show.save

    if @success
      redirect_to shows_path
    else
      head(:unprocessable_entity)
    end
  end

  def edit
    @show = Show.find(params[:id])
  end

  def update
    @show = Show.find(params[:id])
    @show.update_attributes(show_params)
    redirect_to "/"
  end

  private

  def show_params
    params.require(:show).permit(:name, :picture)
  end
end

class StatusesController < ApplicationController 

  def index
    if request.path != statuses_path
      redirect_to statuses_url
    end
    @statuses = Status.includes(:reactions).all
  end

  def show
    @status = Status.find(params[:id])
    # @status_reaction = StatusReaction.new
    @reactions = Reaction.all
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if @status.save # will return true if it's valid and saved to db
      # it worked!
      redirect_to @status
    else
      # something was invalid
      render :new
    end
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    if @status.update(status_params)
      redirect_to @status
    else
      render :edit
    end
  end

  def destroy
    Status.destroy(params[:id])
    redirect_to statuses_path
  end

  private

  def status_params
    params.require(:status).permit(:body)
  end

end

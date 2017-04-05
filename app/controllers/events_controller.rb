class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

# GET /events
# GET /events.json
def index
  @events = Event.all
end

# GET /events/1
# GET /events/1.json
def show
  # @board = Spot.find(params[:spot_id])
  # @event = Event.find(params[:id])
end

# GET /events/new
def new
  @board = Board.find(params[:board_id])
  @event = Event.new
end

# GET /events/1/edit
def edit
end

# POST /events
# POST /events.json
def create
  @board = Board.find(params[:board_id])
  @user = current_user
  @event = @board.events.build(event_params)

  @event.user = current_user
  # @unbooked = Event.where(user_id: @user.id, board_id: @board.id, booked: false)

  respond_to do |format|
    if @event.save
      format.html { redirect_to @board, notice: 'Event was successfully created.' }
      format.json { render :show, status: :created, location: @event }
    else
      format.html { redirect_to @board, notice: 'Reservation creation failed. Make sure dates are valid' }
      format.json { render json: @board.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /events/1
# PATCH/PUT /events/1.json
def update
  respond_to do |format|
    if @event.update(event_params)
      format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      format.json { render :show, status: :ok, location: @event }
    else
      format.html { render :edit }
      format.json { render json: @event.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /events/1
# DELETE /events/1.json
def destroy
  @event.destroy
  respond_to do |format|
    format.html { redirect_to :back, notice: 'Reservation successfully cancelled.' }
    format.json { head :no_content }
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :start_time, :end_time, :booked, :payed)
  end

  def set_current_events
  @some_events = Event.where board_id: @board.id
  @current_events =  @some_events.where start_time >= Time.now

end
end

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    terrainID = session[:search_terrain_id] 
    @events = Event.where(start: params[:start]..params[:end]).where(terrain_id: terrainID)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    user = User.find_by_id(session[:search_user_id])
    terrain = Terrain.find_by_id(session[:search_terrain_id])
    @event = Event.new(event_params)
    @event.user = user
    @event.current = current_user.id
    @event.terrain = terrain
    @event.save
  end

  def update
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  def calendar
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :date_range, :start, :end, :color)
  end
end
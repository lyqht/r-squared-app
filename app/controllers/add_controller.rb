class AddController < ApplicationController
before_action :validate_access 

  def room_params
    params.require(:Room).permit(:room_id, :roomtype, :operate_start, :operate_end)
  end

  def show
    id = params[:id] # retrieve Room ID from URI route
    @room = Room.find(id) # look up Room by unique ID
    # will render app/views/Rooms/show.<extension> by default
  end

  def index
    #@room = Rooms.all
    #params.require(:Room).permit(:room_id, :roomtype, :operate_start, :operate_end)
   # @room = Room.new(:building_name)
    #@rooms = Room.filter_from_params(filtering_params)
    
    @rooms = Room.new(:id => "id")
    #@rooms.save
  end

  def new
    attr_accessor :building_name, :room_id, :roomtype, :description
     def initialize(attributes = {})
      @building_name  = attributes[:building_name]
       @room_id = attributes[:room_id]
       @roomtype = attributes[:roomtype]
       #@description = attributes[:description]
    #   @booked = attributes[:booked]
    #   @booker = attributes[:booker]
       @operate_start = attributes[:operate_start]
      @operate_end = attributes[:operate_end]
      
     end
  end

  def create
    @room = Room.create!(room_params)
    flash[:notice] = "#{@room.name} was successfully created."
    redirect_to rooms_path
  end

  def edit
    @room = Room.find params[:id]
  end

  def update
    @room = Room.find params[:id]
    @room.update_attributes!(Room_params)
    flash[:notice] = "#{@room.name} was successfully updated."
    redirect_to room_path(@room)
  end

  def destroy
    @Room = Room.find(params[:id])
    @Room.destroy
    
    redirect_to delete_path
  end
  
private 
  def validate_access 
      unless logged_in?
        redirect_to root_path
      end 
  end

end

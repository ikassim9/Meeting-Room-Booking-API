# app/controllers/rooms_controller.rb
class RoomsController < ApplicationController
    before_action :set_room, only: %i[ show update destroy ]

  # GET /rooms
  def index
    render json: Room.all
  end

  # GET /rooms/:id
  def show
    render json: @room
  end

  # POST /rooms
  def create
    room = Room.new(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: { errors: room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /rooms/:id
  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: { errors: @room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/:id
  def destroy
    @room.destroy
  end

  private

  def room_params
    params.expect(room: [:name, :capacity, :location])
  end
  # to stay DRY 
  def set_room
      @room = Room.find(params[:id])
  end

end
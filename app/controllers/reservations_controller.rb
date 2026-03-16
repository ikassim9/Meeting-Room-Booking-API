class ReservationsController < ApplicationController
  before_action :set_room
  before_action :set_reservation, only: %i[show destroy]

  # GET /rooms/:room_id/reservations
  # Lists all reservations for a specific room
  def index
    render json: @room.reservations
  end

  # GET /rooms/:id/reservations/:id
  # Shows a single reservation under a specific room
  def show
    render json: @reservation
  end

  # POST /rooms/:id/reservations
  # Creates a new reservation for a specific room
  def create
    reservation = @room.reservations.new(reservation_params)
    if reservation.save
      render json: reservation
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/:id/reservations/:id
  def destroy
    @reservation.destroy
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = @room.reservations.find(params[:id])
  end

  def reservation_params
     params.expect(reservation: [:reserved_by, :start_time, :end_time])
  end
end
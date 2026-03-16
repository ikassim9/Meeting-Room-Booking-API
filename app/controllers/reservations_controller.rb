class ReservationsController < ApplicationController
  before_action :set_room
  before_action :set_reservation, only: %i[show destroy]

  def index
    render json: @room.reservations
  end

  def show
    render json: @reservation
  end

  def create
    reservation = @room.reservations.new(reservation_params)
    if reservation.save
      render json: reservation
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

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

module Admin
  class AttendancesController < ApplicationController
    before_action :set_attendance, only: [:show, :edit, :update, :destroy]

    def index
      @attendances = Attendance.includes(:agent).all
    end

    def show; end

    def new
      @attendance = Attendance.new
    end

    def create
      @attendance = Attendance.new(attendance_params)
      @attendance.check_in ||= Time.current
      if @attendance.save
        redirect_to admin_attendance_path(@attendance), notice: "Présence créée avec succès."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @attendance.update(attendance_params)
        redirect_to admin_attendance_path(@attendance), notice: "Présence mise à jour avec succès."
      else
        render :edit
      end
    end

    def destroy
      @attendance.destroy
      redirect_to admin_attendances_path, notice: "Présence supprimée."
    end

    private

    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:agent_id, :status, :check_in, :check_out)
    end
  end
end

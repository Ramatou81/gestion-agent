
module Admin
class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  def index
    @departments = Department.all.order(:name)
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
  @department = Department.new(department_params)
  if @department.save
    redirect_to admin_department_path(@department), notice: "Le département a été créé avec succès."
  else
    render :new, status: :unprocessable_entity
  end
end


  def edit
  end

def update
  if @department.update(department_params)
    redirect_to admin_department_path(@department), notice: "Le département a été mis à jour avec succès."
  else
    render :edit, status: :unprocessable_entity
  end
end

  def destroy
  @department.destroy
  redirect_to admin_departments_path, notice: "Le département a été supprimé avec succès."
end


  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :description, :manager_id)
  end
end
end
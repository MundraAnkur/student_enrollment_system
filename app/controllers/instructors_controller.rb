class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[show edit update destroy]
  before_action :authenticate_instructor!, only: %i[index]
  before_action :authenticate_admin!, except: %i[index]

  def index
    @courses = (Course.where(instructor_id: current_instructor.id) unless current_instructor.id.nil?)
  end

  def show; end

  def new
    @instructor = Instructor.new
  end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to admin_instructors_url, notice: "Instructor #{@instructor.name} was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    name = @instructor.name
    @instructor.destroy
    redirect_to admin_instructors_url, notice: "Instructor #{name} was successfully removed"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_instructor
    @instructor = Instructor.find(params[:id])
    redirect_to admin_instructors_url, notice: "Instructor with id #{params[:id]} not there!" if @instructor.nil?
  end

  # Only allow a list of trusted parameters through.
  def instructor_params
    params.require(:instructor).permit(:name, :email, :password, :department)
  end
end

class StudentsController < ApplicationController
  before_action :set_student, only: %i[enrolled_courses edit update destroy]
  before_action :authenticate_admin!, only: [:enrolled_courses]
  before_action :authenticate_student?, except: [:enrolled_courses]

  def index
    @student = current_student || Student.find_by(student_id: params[:id])
    if @student.nil?
      redirect_back fallback_location: admin_students_path, notice: "Student #{params[:id]} not there!"
    else
      enrolled_course_codes = Enroll.where(student_id: @student.student_id).pluck(:course_id)
      @courses = Course.where.not(code: enrolled_course_codes)
      @enrolled_courses = Course.where(code: Enroll.where(student_id: @student[:id], waitlist: false).pluck(:course_id))
      @waitlistedcourses = Course.where(code: Enroll.where(student_id: @student[:id], waitlist: true).pluck(:course_id))
    end
  end

  def enrolled_courses
    enrolled_course_codes = Enroll.where(student_id: @student.student_id).pluck(:course_id)
    @enrolled_courses = Course.where(code: enrolled_course_codes)
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    if @student.update(students_params)
      redirect_to admin_students_url, notice: "Student #{@student.name} was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    name = @student.name
    @student.destroy
    redirect_to admin_students_url, notice: "Student #{name} was successfully removed"
  end

  private

  def authenticate_student?
    admin_signed_in? || authenticate_student!
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = current_student || Student.find_by(student_id: params[:id])
    redirect_back fallback_location: admin_students_path, notice: "Student with id #{params[:id]} not there!" if @student.nil?
  end

  # Only allow a list of trusted parameters through.
  def students_params
    params.require(:student).permit(:student_id, :name, :dob, :email, :phone, :major)
  end
end

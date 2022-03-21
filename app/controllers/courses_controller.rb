# frozen_string_literal: true
class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy enrolled enroll]
  before_action :authenticate_instructor?, except: [:show]

  # GET /courses
  def index
    @courses = if !current_instructor.nil?
                 Course.where(instructor_id: current_instructor.id)
               elsif !params[:instructor_id].nil?
                 Course.where(instructor_id: params[:instructor_id])
               else
                 Course.all
               end
  end

  def enrolled
    course_enrolled_students = Enroll.where(course_id: params[:id], waitlist: false).pluck(:student_id)
    course_wait_listed_students = Enroll.where(course_id: params[:id], waitlist: true).pluck(:student_id)
    @enrolled_students = Student.where(student_id: course_enrolled_students)
    @wait_listed_students = Student.where(student_id: course_wait_listed_students)
  end

  def enroll
    course_enrolled_students = Enroll.where(course_id: params[:id]).pluck(:student_id)
    @students = Student.where.not(student_id: course_enrolled_students)
  end

  # GET /courses/1
  def show; end

  # GET /courses/new
  def new
    @course = Course.new
    @instructor = current_instructor
    @instructors = Instructor.all
  end

  # GET /courses/1/edit
  def edit
    if current_instructor && @course.instructor != current_instructor
      redirect_to courses_url, notice: "You are not authorised to edit course #{params[:id]}!"
    end
    @instructor = current_instructor
    @instructors = Instructor.all
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.instructor = current_instructor unless current_instructor.nil?
    @course[:instructor_name] = Instructor.find(@course.instructor_id).name
    # @course[:instructor_id] = Instructor.where(name: @course.instructor_name).get_primary_key(:id)

    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      @instructor = current_instructor
      @instructors = Instructor.all
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      @instructor = current_instructor
      @instructors = Instructor.all
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def authenticate_instructor?
    admin_signed_in? || authenticate_instructor!
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find_by_code(params[:id])
    redirect_to courses_url, notice: "Course #{params[:id]} not there!" if @course.nil?
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:name, :description, :instructor_name, :weekday1, :weekday2, :start_time, :end_time,
                                   :code, :capacity, :waitlist_capacity, :status, :room, :instructor_id)
  end
end

class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[destroy]
  before_action :authenticate_member!

  # POST /enrolls
  def create
    @enroll = Enroll.new
    @enroll.student = current_student || Student.find_by(student_id: params[:student_id])
    @enroll.course_id = params[:course_id]

    if @enroll.course[:status] == 'CLOSED'
      puts '===================Course is CLOSED - Enrollment was not done======================='
      redirect_back fallback_location: student_root_path, notice: 'Course is CLOSED - Enrollment was not done!'
      return
    end

    if @enroll.save
      if admin_signed_in?
        redirect_back fallback_location: admin_students_path,
                      notice: get_enrollment_message(@enroll[:waitlist], @enroll.course[:code], @enroll.student[:name])
      else
        redirect_back fallback_location: student_root_path,
                      notice: get_enrollment_message(@enroll[:waitlist], @enroll.course[:code], @enroll.student[:name])
      end
    else
      redirect_back fallback_location: student_root_path, notice: 'Enrollment unsuccessful!'
    end
  end

  # DELETE /enrolls/1
  def destroy
    @course = Course.find_by(code: @enroll[:course_id])
    @student = Student.find_by(student_id: @enroll[:student_id])

    @enroll.destroy
    if admin_signed_in?
      redirect_back fallback_location: admin_students_path, status: 303, notice: "#{@student.name} is dropped from #{@course.name}!"
    else
      redirect_back fallback_location: student_root_path, status: 303, notice: "#{@student.name} is dropped from #{@course.name}!"
    end
  end

  private

  def get_enrollment_message(waitlist, course_name, student_name)
    if waitlist
      "Successfully Wait Listed #{student_name} in #{course_name}!"
    else
      "Successfully Enrolled #{student_name} in #{course_name}!"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_enroll
    @enroll = Enroll.find(params[:id])
    redirect_back fallback_location: student_root_path, notice: "Enrollment doesn't exist!" if @enroll.nil?
  end
end

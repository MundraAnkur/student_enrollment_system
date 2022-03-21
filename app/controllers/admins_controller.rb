class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index; end

  def instructors
    @instructors = Instructor.all
  end

  def courses
    @courses = Course.all
  end

  def students
    @students = Student.all
  end
end

class StudentsController < ApplicationController
  #authorizes user
  private def authorized?
    unless current_user.admin? || !current_user.teacher?\
      # go to previous page before request, backup is home page
      redirect_back(fallback_location: root_path)
    end
  end
  #check if user is admin
  private def isAdmin?
    unless current_user.admin?
      redirect_back(fallback_location: root_path)
    end
  end
  #single student applications
  def show
    authorized?
    @student = Student.find(params[:id])
    #@student = Student.find(params[:id])
  end

  def new
    authorized?
    @student = Student.new
  end

  #courses that only need graders
  def open_courses
    @courses = Course.all
  end

  #all student applications
  def index
    isAdmin?
    @students = Student.order(params[:sort])
  end

  def create
    authorized?
    @student = Student.new(student_params)
    @student.email = current_user.email
    if @student.save
      redirect_to @student
    else
      render 'new'
    end
  end

  def edit
    authorized?
    @student = Student.find(params[:id])
  end

  def update
    authorized?
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to @student
    else
      render 'edit'
    end
  end


  private def student_params
    params.require(:student).permit(:firstname, :lastname, :dotnumber, :preferences,
                                    :mondaystart, :mondayend, :tuesdaystart, :tuesdayend,
                                    :wednesdaystart, :wednesdayend,
                                    :thursdaystart, :thursdayend, :fridaystart,
                                    :fridayend,
                                    grades_attributes: Grade.attribute_names.map(&:to_sym).push(:_destroy),)
  end

end

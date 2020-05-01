class CoursesController < ApplicationController
  def refresh
    Course.destroy_all
    # create an array to hold all of the sections
    classes = []
    # get url to be scraped
    url = 'https://web.cse.ohio-state.edu/oportal/schedule_display'
    # mechanize and parse the page with Mechanize and Nokogiri
    agent = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }
    unparsed_page = agent.get(url).body
    parsed_page = Nokogiri::HTML(unparsed_page)
    # get array of all instances of div panel, this gets all the classes
    class_names = parsed_page.css('div.panel.panel-default')
    # for each classes get necessary info
    class_names.each do |class_name|

      # the title will be in the 'a' sections
      title = class_name.css('a').text
      title = title.split[0..1].join(' ')
      # there are subgroups in the div panel (group 0 and group 1 ) to get
      # information divide into arrays of these groups
      subgroups0 = class_name.css('tr.group0')
      # for each subgroup get the necessary components from table
      subgroups0.each do |subgroup|
        variables = subgroup.css('td')

        section = {class_id: title,
                   section: variables[0].text,
                   component: variables[1].text,
                   period: variables[3].text,
                   location: variables[2].text,
                   professor: variables[4].text,
        }
        # put in array
        classes << section
      end

      # do the same for the other group of subgroup 1
      subgroups1 = class_name.css('tr.group1')
      subgroups1.each do |subgroup|
        # get necessary elements from the table in that subgroup
        variables = subgroup.css('td')

        section = {class_id: title,
                   section: variables[0].text,
                   component: variables[1].text,
                   period: variables[3].text,
                   location: variables[2].text,
                   professor: variables[4].text

        }
        # put in the array
        classes << section
      end


    end

    #add to the course the scraped classes
    classes.each do |c|
      temp = c[:period].to_s
      #ARR means it doesnt have a time so change the time to 00:00
      if temp != 'ARR'
        #split start and end time
        timesplit = temp.split(' ')
        #put in seperate fields
        days = timesplit[0]
        start = timesplit[1]
        finish = timesplit[3]
      else
        days = 'ARR'
        start = '00:00'
        finish = '00:00'
      end
      #parse those into time object
      start2 = Time.parse(start)
      finish2 = Time.parse(finish)


      #add info to Course
      Course.create(class_id: c[:class_id],
                    section: c[:section],
                    component: c[:component],
                    days: days,
                    start: (start2 - 18000),
                    end: (finish2 - 18000),
                    location: c[:location],
                    professor: c[:professor],
                    grader: c[:grader],
                    gradersneeded: 2,
                    gradersfilled: 0)
    end
    #refresh to index
    redirect_to courses_path
  end

  def index
    #@courses = Course.order(params[:sort])
    @courses = filter(params)
  end

  #add various filters for course selection page
  private def filter(params)
    filter = Course.all
    if params[:class_id].present?
      filter = filter.where(class_id: params[:class_id])
    end
    if params[:professor].present?
      filter = filter.where(professor: params[:professor])
    end
    if params[:days].present?
      filter = filter.where(days: params[:days])
    end
    if params[:start].present?
      filter = filter.where(start: params[:start])
    end
    if params[:end].present?
      filter = filter.where(end: params[:end])
    end
    if params[:component].present?
      filter = filter.where(component: params[:component])
    end
    return filter
  end

  def new
    authorized?
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    authorized?
    @course = Course.new(course_params)
    #checks validity of the course by using validations, only then allows user to save
    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  #only allow authorized people to edit courses
  def edit
    authorized?
    @course = Course.find(params[:id])
  end

  #only allow authorized people to update courses
  def update
    authorized?
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    authorized?
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end

  #checks the authorization of the user and whether they have admin privileges
  private def authorized?
    unless current_user.admin?
      redirect_back(fallback_location: root_path)
    end
  end

  private def course_params
    params.require(:course).permit(:class_id, :section, :component, :days,
                                   :start, :end, :location, :professor, :grader, :gradersneeded, :gradersfilled)
  end
end

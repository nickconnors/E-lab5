# frozen_string_literal: true
class Course < ApplicationRecord
  serialize :student_recs, Array
  validates :class_id, format: {with: /\A[A-Z]{3} \d{4}\z/,
                                message: ' format must be 3 Capital letters a space and 4 digits'}
  validates :component, inclusion: {in: %w[LEC LAB IND], message: ' must be LEC, LAB or IND.'}
  validates :section, numericality: {only_integer: true, message: ' must be a number.'}, allow_nil: true
  validates :gradersneeded, numericality: {only_integer: true, message: ' must be a number.'}, allow_nil: true
  validates :gradersfilled, numericality: {only_integer: true, message: ' must be a number.'}, allow_nil: true

  def assign_teachers_assistant
    courses = Course.where("gradersneeded > 0")
    students = Student.all # grab all students
    courses.each do |c|

      days = c.days.split('') # array of days, ex, [M, W, F]

      studentsAvailM = Array.new # array with students available Monday
      studentsAvailT = Array.new # array with students available Tuesday
      studentsAvailW = Array.new # array with students available Wednesday
      studentsAvailR = Array.new # array with students available Thursday
      studentsAvailF = Array.new # array with students available Friday

      students.each do |s|
        if days.include? 'M'
          # if course is on Monday, grab each student and see if they are available during class time
          sStartTime = s.mondaystart
          sEndTime = s.mondayend # grab student Monday start and end times
          courseStartTime = c.start
          courseEndTime = c.end # grab course start and end times
          if (sStartTime < courseStartTime) && (sEndTime > courseEndTime) # if student is available
            # add student to an array of students available to TA this course on Mondays
            studentsAvailM << s
          end
        end

        if days.include? 'T'
          # check if student is available between class start and end on Tues
          sStartTime = s.tuesdaystart
          sEndTime = s.tuesdayend # grab student Monday start and end times
          courseStartTime = c.start
          courseEndTime = c.end # grab course start and end times
          if (sStartTime < courseStartTime) && (sEndTime > courseEndTime) # if student is available
            # add student to an array of students available to TA this course on Tuesdays
            studentsAvailT << s
          end
        end

        if days.include? 'W'
          # check if student is available between class start and end on Wed
          sStartTime = s.wednesdaystart
          sEndTime = s.wednesdayend # grab student Monday start and end times
          courseStartTime = c.start
          courseEndTime = c.end # grab course start and end times
          if (sStartTime < courseStartTime) && (sEndTime > courseEndTime) # if student is available
            # add student to an array of students available to TA this course on Wednesdays
            studentsAvailW << s
          end
        end

        if days.include? 'R'
          # check if student is available between class start and end on Thurs
          sStartTime = s.thursdaystart
          sEndTime = s.thursdayend # grab student Monday start and end times
          courseStartTime = c.start
          courseEndTime = c.end # grab course start and end times
          if (sStartTime < courseStartTime) && (sEndTime > courseEndTime) # if student is available
            # add student to an array of students available to TA this course on Thursdays
            studentsAvailR << s
          end
        end

        if days.include? 'F'
          # check if student is available between class start and end on Friday
          sStartTime = s.fridaystart
          sEndTime = s.fridayend # grab student Monday start and end times
          courseStartTime = c.start
          courseEndTime = c.end # grab course start and end times
          if (sStartTime < courseStartTime) && (sEndTime > courseEndTime) # if student is available
            # add student to an array of students available to TA this course on Fridays
            studentsAvailF << s
          end
        end

        # check if student is available on all days the class is
        if check_if_free_all_days(days, s, studentsAvailM, studentsAvailT, studentsAvailW, studentsAvailR, studentsAvailF)
          recommendations = Recommendation.all
          recommendations.each do |r|
            recommendationAttributesArray = r.attributes.values
            #check if current student is recommended for the current course
            if recommendationAttributesArray.include?((s.lastname) && (s.dotnumber))
              if (r.class_id.eql?(c.class_id))
                # if the recommendation is for the current course
                # assign the current student to the current course
                assign_grader(c, s)
              end
            elsif !recommendationAttributesArray.include?((s.lastname) && (s.dotnumber))
              # if student is not recommended, check if they prefer the course
              # grab array of grades for the current student
              studentsGrades = Grade.where(student_id: s.id)
              studentsGrades.each do |g|
                if (c.gradersneeded > 0 && c.class_id.eql?(g.section) && g.preference)
                  #assign student to the course if they prefer it
                  assign_grader(c, s)
                end
              end
            end
          end
          #if the student is not recommended, and does not prefer the course, assign them anyways
          #to fill the spot
          if (c.gradersneeded > 0)
            assign_grader(c, s)
          end
        end
      end
      # if there were no graders that could be added, state that in the course's "graders" attribute
      courses.each do |k|
        if (k.gradersneeded > 0)
          k.grader = "No Graders Available"
          k.save
        end
      end
    end
  end

  def check_if_free_all_days(days, s, studentsAvailM, studentsAvailT, studentsAvailW, studentsAvailR, studentsAvailF)
    studentEligibleForCourse = true
    #we need to make sure the student is free on all days the course is on
    if (days.include? 'M') && !studentsAvailM.include?(s)
      studentEligibleForCourse = false
    end

    if (days.include? 'T') && !studentsAvailT.include?(s)
      studentEligibleForCourse = false
    end

    if (days.include? 'W') && !studentsAvailW.include?(s)
      studentEligibleForCourse = false
    end

    if (days.include? 'R') && !studentsAvailR.include?(s)
      studentEligibleForCourse = false
    end

    if (days.include? 'F') && !studentsAvailF.include?(s)
      studentEligibleForCourse = false
    end
    studentEligibleForCourse
  end

  def assign_grader(currentCourse, student)
    currentCourse.grader = student.email #grader is now assigned to a class
    currentCourse.save
  end

end

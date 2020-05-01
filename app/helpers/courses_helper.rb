module CoursesHelper
  def rec(course)
    arr = []
    students = Student.all
    #go through each student app to see if they can TA
    students.each do |student|
      day = 0
      pts = 0
      g = false
      timecheck = false

      #check that they recieved a good grade in the class
      student.grades.each do |grade|
        if (grade.section == course.class_id) && ((grade.grade == 'A') || (grade.grade == 'A-') || (grade.grade == 'A-'))
          g = true
          if grade.preference
            pts += 1
          end
        end
      end
      #if it is a LAB check availability
      if course.component == 'LAB'
        if (course.days.include? 'M') && (course.start > student.mondaystart) && (course.end < student.mondayend)
          day += 1
        end

        if (course.days.include? 'T') && (course.start > student.tuesdaystart) && (course.end < student.tuesdayend)
          day += 1
        end

        if (course.days.include? 'W') && (course.start > student.wednesdaystart) && (course.end < student.wednesdayend)
          day += 1

        end

        if (course.days.include? 'R') && (course.start > student.thursdaystart) && (course.end < student.thursdayend)
          day += 1
        end

        if (course.days.include? 'F') && (course.start > student.fridaystart) && (course.end < student.fridayend)
          day += 1
        end
        #confirm that they can make every day the class is held
        if course.days.length == day
          timecheck = true
        end
      else
        timecheck = true
      end

      #give more points the more recommendations
      recs = Recommendation.where(lastname: student.lastname, dotnumber: student.dotnumber, class_id: course.class_id)
      pts += recs.length

      #give high amount of points for request to put the at top of list
      reqs = Request.where(lastname: student.lastname, dotnumber: student.dotnumber, section: course.section)
      if (reqs.length > 0)
        pts += 100
      end

      #check that they did not get a negative review under 5
      evals = Evaluation.where(lastname: student.lastname, dotnumber: student.dotnumber, class_id: course.class_id)

      check = true
      evals.each do |e|
        if (eval.rating < 5)
          check = false
        end
      end
      # verify that student meets requirements
      if (g == true) && (timecheck == true) && check
        i = 0
        #order in array by pts
        while ((i < arr.length) && (pts > arr[i][1]))
          i = i + 1
        end
        #insert at designated position
        arr.insert(i, [student.email, pts])
      end

    end
    arr
  end
end

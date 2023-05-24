class Gradebook
  attr_reader :instructor,
              :courses

  def initialize(instructor)
    @instructor = instructor
    @courses = []
  end

  def add_course(course)
    @courses << course
  end

  def list_all_students
    students_by_course = {}
    @courses.each do |course|
      students_by_course[course] = course.students
    end
    students_by_course
  end


  def students_below_threshold(score)
    @courses.flat_map do |course|
      course.students.find_all do |student|
        student.grade < score
      end
    end
  end
  
end

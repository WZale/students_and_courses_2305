require 'rspec'
require './lib/course'
require './lib/student'
require './lib/gradebook'

RSpec.describe Gradebook do
  before(:each) do
    @course_1 = Course.new("Calculus", 2)
    @course_2 = Course.new("Intro to Ruby", 30)
    @course_3 = Course.new("Intro to Rails", 30)

    @student_1 = Student.new({name: "Morgan", age: 21})
    @student_2 = Student.new({name: "Jordan", age: 29}) 
    @student_3 = Student.new({name: "Will", age: 35}) 
    @student_4 = Student.new({name: "Justin", age: 36}) 

    @gradebook = Gradebook.new("Kat")
  end

  describe "#exists" do
    it "exists with readable attributes" do
      expect(@gradebook).to be_an_instance_of(Gradebook)
      expect(@gradebook.instructor).to eq("Kat")
      expect(@gradebook.courses).to eq([])
    end
  end

  describe "#add_course" do
    it "can add courses" do
      @gradebook.add_course(@course_2)
      @gradebook.add_course(@course_3)

      expect(@gradebook.courses).to eq([@course_2, @course_3])
    end
  end
  
  describe "#list_all_students" do
    it "can list all students in a course" do
      @gradebook.add_course(@course_2)
      @gradebook.add_course(@course_3)

      @course_2.enroll(@student_3)
      @course_2.enroll(@student_4)
      expect(@course_2.students).to eq([@student_3, @student_4])
      
      @course_3.enroll(@student_1)
      @course_3.enroll(@student_2)
      expect(@course_3.students).to eq([@student_1, @student_2])

      expected = {
                  @course_2 => [@student_3, @student_4],
                  @course_3 => [@student_1, @student_2]
                }

      expect(@gradebook.list_all_students).to eq(expected)
    end
  end

  describe "#students_below_threshold" do
    it "can list students who have a grade below a given threshold" do
      @gradebook.add_course(@course_2)
      @gradebook.add_course(@course_3)

      @course_2.enroll(@student_3)
      @student_3.log_score(95)
      @student_3.log_score(80)
      @student_3.log_score(76)
      expect(@student_3.grade).to eq(83.67)
      
      @course_2.enroll(@student_4)
      @student_4.log_score(96)
      @student_4.log_score(76)
      @student_4.log_score(80)
      expect(@student_4.grade).to eq(84)
      
      @course_3.enroll(@student_1)
      @student_1.log_score(60)
      @student_1.log_score(50)
      @student_1.log_score(70)
      expect(@student_1.grade).to eq(60)

      @course_3.enroll(@student_2)
      @student_2.log_score(77)
      @student_2.log_score(43)
      @student_2.log_score(81)
      expect(@student_2.grade).to eq(67)

      expect(@gradebook.students_below_threshold(70)).to eq([@student_1, @student_2])
    end
  end

  describe "#all_grades" do
    it "can list all grades in a course" do
      @gradebook.add_course(@course_2)
      @gradebook.add_course(@course_3)

      @course_2.enroll(@student_3)
      @student_3.log_score(95)
      @student_3.log_score(80)
      @student_3.log_score(76)
      expect(@student_3.grade).to eq(83.67)
      
      @course_2.enroll(@student_4)
      @student_4.log_score(96)
      @student_4.log_score(76)
      @student_4.log_score(80)
      expect(@student_4.grade).to eq(84)
      
      @course_3.enroll(@student_1)
      @student_1.log_score(60)
      @student_1.log_score(50)
      @student_1.log_score(70)
      expect(@student_1.grade).to eq(60)

      @course_3.enroll(@student_2)
      @student_2.log_score(77)
      @student_2.log_score(43)
      @student_2.log_score(81)
      expect(@student_2.grade).to eq(67)

      expected = {
        @course_2 => [83.67, 84],
        @course_3 => [60, 67]
      }
      
      expect(@gradebook.all_grades).to eq(expected)
    end
  end

    describe "#students_in_range(min, max)" do
      it "can find all students across all courses that have grades in a given range" do
        @gradebook.add_course(@course_2)
      @gradebook.add_course(@course_3)

      @course_2.enroll(@student_3)
      @student_3.log_score(95)
      @student_3.log_score(80)
      @student_3.log_score(76)
      expect(@student_3.grade).to eq(83.67)
      
      @course_2.enroll(@student_4)
      @student_4.log_score(96)
      @student_4.log_score(76)
      @student_4.log_score(80)
      expect(@student_4.grade).to eq(84)
      
      @course_3.enroll(@student_1)
      @student_1.log_score(60)
      @student_1.log_score(50)
      @student_1.log_score(70)
      expect(@student_1.grade).to eq(60)

      @course_3.enroll(@student_2)
      @student_2.log_score(77)
      @student_2.log_score(43)
      @student_2.log_score(81)
      expect(@student_2.grade).to eq(67)

      expect(@gradebook.students_in_range(60, 70)).to eq([@student_1, @student_2])
    end
  end

end
require 'rspec'
require './lib/course'
require './lib/student'

RSpec.describe Course do 
  before(:each) do
    @course = Course.new("Calculus", 2)

    @student1 = Student.new({name: "Morgan", age: 21})
    @student2 = Student.new({name: "Jordan", age: 29}) 
  end

  describe "#exists" do
    it "exists with readable attributes" do
      expect(@course).to be_an_instance_of(Course)

      expect(@course.name).to eq("Calculus")
      expect(@course.capacity).to eq(2)
      expect(@course.students).to eq([])
    end
  end

  describe "#full" do
    it "can report if capacity is met or not" do
      expect(@course.full?).to be(false)
    end
  end

  describe "#enroll" do
    it "can enroll students in a course" do
      @course.enroll(@student1)
      @course.enroll(@student2)

      expect(@course.students).to eq([@student1, @student2])

      expect(@course.full?).to be(true)
    end
  end
end
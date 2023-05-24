require 'rspec'
require './lib/student'

RSpec.describe Student do
  before(:each) do
    @student = Student.new({name: "Morgan", age: 21})
  end

  describe "#exists" do
    it "exists with readable attributes" do
      expect(@student).to be_an_instance_of(Student)

      expect(@student.name).to eq("Morgan")
      expect(@student.age).to eq(21)
      expect(@student.scores).to eq([])
    end
  end

  describe "#log_score" do
    it "can log scores" do
      @student.log_score(89)
      @student.log_score(78)
      
      expect(@student.scores).to eq([89, 78])
    end
  end
  
  describe "#grade" do
    it "can average scores for a grade" do
      @student.log_score(89)
      @student.log_score(78)
      expect(@student.grade).to eq(83.5)
    end
  end

end
class Student
  attr_reader :name,
              :age,
              :scores

  def initialize((student_info))
    @name = student_info[:name]
    @age = student_info[:age]
    @scores = []
  end

  def log_score(score)
    @scores << score
  end

  def grade
    (@scores.sum / @scores.length.to_f).round(2)  
  end
end

class Course
  attr_accessor :id, :code, :name, :credits, :grade1, :grade2, :grade3, :grade_average, :term, :year, :code2
  def gpa_scale
    if self.grade_average >=9
      return 4
    elsif self.grade_average >=8
      return 3
    elsif self.grade_average >=7
      return 2
    end
    return 1
  end
  def gpa_scale_letter
    if self.grade_average >=9
      return 'A'
    elsif self.grade_average >=8
      return 'B'
    elsif self.grade_average >=7
      return 'C'
    end
    return 'D'
  end
end

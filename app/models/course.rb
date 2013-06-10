class Course
  attr_accessor :id, :code, :name, :credits, :grade_average, :term, :year, :code2
  def gpa_scale
    if self.grade_average >=9
      return 4
    elsif self.grade_average >=8
      return 3.9
    elsif self.grade_average >=7
      return 3.3
    elsif self.grade_average >=6.5
      return 3.0
    end
    return 2.3
  end
  def gpa_scale_letter
    if self.grade_average >=9
      return 'A+'
    elsif self.grade_average >=8
      return 'A'
    elsif self.grade_average >=7
      return 'B+'
    elsif self.grade_average >6.5
      return 'B'
    end
    return 'C'
  end
end

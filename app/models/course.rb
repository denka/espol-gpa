class Course
  attr_accessor :id, :code, :name, :credits, :grade1, :grade2, :grade3, :grade_average, :term, :year, :code2
  def gpa_scale
    if self.grade_average >=9
      return 4
    elsif self.grade_average >=8.5
      return 4
    elsif self.grade_average >=8
      return 3.7
    elsif self.grade_average >7.7
      return 3.3
    elsif self.grade_average >=7.3
      return 3.0
    elsif self.grade_average >=7
      return 2.7
    elsif self.grade_average >=6.7
      return 2.3
    elsif self.grade_average >=6.3
      return 2
    end
    return 1.7
  end
  def gpa_scale_letter
    if self.grade_average >=9
      return 'A+'
    elsif self.grade_average >=8.5
      return 'A'
    elsif self.grade_average >=8
      return 'A-'
    elsif self.grade_average >7.7
      return 'B+'
    elsif self.grade_average >=7.3
      return 'B'
    elsif self.grade_average >=7
      return 'B-'
    elsif self.grade_average >=6.7
      return 'C+'
    elsif self.grade_average >=6.3
      return 'C'
    end
    return 'C-'
  end
end

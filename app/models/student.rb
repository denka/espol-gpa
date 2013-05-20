class Student
  attr_reader :matricula,:firstname, :lastname, :career, :division, :data, :courses, :credits

  def initialize(matricula)
    client = Savon::Client.new("https://www.academico.espol.edu.ec/Services/wsSAAC.asmx?WSDL")
    response = client.request :web, :materias_malla_aprobadas, body: { :matricula => matricula }
    raw_data = response.to_hash[:materias_malla_aprobadas_response][:materias_malla_aprobadas_result][:diffgram][:new_data_set][:v_materias_acreditadas]
    response = client.request :web, :creditos_estudiante, body: { "codigoEstudiante" => matricula, "codigoDivision" => '', "codigoCarrera" => '', "codigoEspecializacion" => '' }
    @data = response.to_hash[:creditos_estudiante_response][:creditos_estudiante_result]
    #@data=raw_data
    @firstname=@data[:nombres]
    @lastname=@data[:apellidos]
    @career=@data[:nombre_carrera]
    @matricula=matricula;
    @credits= Array.new
    @courses= Array.new
    @data[:creditos][:tipo_credito].each do |d|
      d[:materias_creditos][:materia].each do |c|
        @credits << c
      end
    end
    raw_data.each do |d|
      if d[:promedio].to_f!=0 
        course = Course.new
        course.code= d[:codmateria]
        course.name= d[:nommateria]
        course.grade1= d[:nota1].to_f unless d[:nota1].nil?
        course.grade2= d[:nota2].to_f unless d[:nota2].nil?
        course.grade3= d[:nota3].to_f unless d[:nota3].nil?
        course.grade_average= d[:promedio].to_f unless d[:promedio].nil?
        course.year= d[:anio] unless d[:anio].nil?
        course.term= d[:termino] unless d[:termino].nil?
        @courses << course
      end
    end
  end
  def calculate_gpa
    grades=0
    self.courses.each do |c|
      if c.grade_average<=10 && c.grade_average>9
        val=4 #A
      elsif c.grade_average<=9 && c.grade_average>8
        val=3 #B
      elsif c.grade_average<=8 && c.grade_average>7
        val=2 #C
      elsif c.grade_average<=7 && c.grade_average>=6
        val=1 #D
      end
      grades+=val*4
    end
    return grades/courses.size
  end
end

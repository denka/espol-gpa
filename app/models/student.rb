class Student
  attr_reader :matricula,:firstname, :lastname, :career, :division, :courses, :credits

  def initialize(matricula)
    client = Savon::Client.new("https://www.academico.espol.edu.ec/Services/wsSAAC.asmx?WSDL")
    response = client.request :web, :materias_malla_aprobadas, body: { :matricula => matricula }
    raw_data = response.to_hash[:materias_malla_aprobadas_response][:materias_malla_aprobadas_result][:diffgram][:new_data_set][:v_materias_acreditadas]
    response = client.request :web, :creditos_estudiante, body: { "codigoEstudiante" => matricula, "codigoDivision" => '', "codigoCarrera" => '', "codigoEspecializacion" => '' }
    data = response.to_hash[:creditos_estudiante_response][:creditos_estudiante_result]
    #@data=raw_data
    @firstname=data[:nombres]
    @lastname=data[:apellidos]
    @career=data[:nombre_carrera]
    @matricula=matricula;
    @credits= Hash.new
    @courses= Array.new
    data[:creditos][:tipo_credito].each do |d|
      d[:materias_creditos][:materia].each do |c|
        cindex=c[:codigo_materia].strip
        @credits[cindex] = c[:numero_credito].to_i unless cindex.nil?
      end
    end
    raw_data.each do |d|
      if d[:promedio].to_f!=0 
        course = Course.new
        code= d[:codmateria].to_s.strip
        course.code= code
        course.name= d[:nommateria].to_s
        course.grade1= d[:nota1].to_f unless d[:nota1].nil?
        course.grade2= d[:nota2].to_f unless d[:nota2].nil?
        course.grade3= d[:nota3].to_f unless d[:nota3].nil?
        course.grade_average= d[:promedio].to_f unless d[:promedio].nil?
        course.year= d[:anio] unless d[:anio].nil?
        course.credits=@credits[code] #unless @credits[code].nil?
        course.term= d[:termino] unless d[:termino].nil?
        @courses << course
      end
    end
  end
  def calculate_gpa
    val=1
    grades=0
    credits=0
    @division=0
    self.courses.collect do |c|
      @division+=1
      credits+=c.credits
      grades+=(c.gpa_scale*c.credits.to_f)
    end
    #credits=self.credits.sum
    return grades/credits.to_f
  end
end

class StudentsController < ApplicationController
  def index
    if params[:matricula]
      @student= Student.new(params[:matricula])
    end
  end
end

class StudentsController < ApplicationController
  def index
    if params[:matricula]
      @student= Student.new(params[:matricula])
    end
    #render :json => @student.credits
  end
end

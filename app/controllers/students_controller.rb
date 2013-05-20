class StudentsController < ApplicationController
  def index
    if params[:matricula]
      @student= Student.new(params[:matricula])
    end
  end
  def show
    @student= Student.new(params[:matricula])
    #render :json => @student
  end
end

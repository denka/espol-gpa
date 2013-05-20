class StudentsController < ApplicationController
  def show
    @student= Student.new(params[:id])
    render :json => @student
  end
end

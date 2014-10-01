class Api::V1::SectionsController < ApplicationController
  def index
    @response = Hash.new
    @response["status"] = 0
    @response["message"] = 1
    @response["sections"] = Section.all
    render :json => @response
  end

  def show
    @response = Hash.new
    if(params[:id].to_i.to_s == params[:id] && params[:id].to_f == params[:id].to_i)
      if(!Section.exists?(params[:id]))
        @response["status"] = 2
        @response["message"] = "section didn't exists"
        render :json => @response, status: 400
        return
      end
    else
      @response["status"] = 1
      @response["message"] = "Invalid id"
      render :json => @response, status: 400
      return
    end
    @response["status"] = 0
    @response["message"] = 'ok'
    @response["section"] = Section.find(params[:id])
    render :json => @response 
  end
end
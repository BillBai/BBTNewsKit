class Api::V1::PublishersController < ApplicationController
  def index
    @response = Hash.new
    @response["status"] = 0
    @response["message"] = 1
    @response["Publishers"] = Publisher.all
    render :json => @response
  end
end
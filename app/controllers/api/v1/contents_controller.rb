class Api::V1::ContentsController < ApplicationController
  def index
    response = Hash.new

    if((params.include?('from_id') && !params[:from_id].is_a?(Integer)) && (params.include?('limit') && !params[:id].is_a?(Integer)))
      response["status"] = 1
      response["message"] = 'Invaild params'
      render :json => response
      return
    end

    if(params.include?('limit'))
      limit = params[:limit].to_i
    else
      limit = 10
    end

    if(params.include?('from_id'))
      list = Content.getList(params[:from_id],limit)
    else
      list = Content.getList('',limit)
    end

    response["status"] = 1
    response["message"] = 'ok'
    response["list"] = list
    render :json => response
  end
end
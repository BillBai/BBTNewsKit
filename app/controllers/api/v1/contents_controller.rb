class Api::V1::ContentsController < ApplicationController
  def index
    @response = Hash.new
    if(params.include?('from_id') && (params[:from_id].to_i.to_s != params[:from_id] || params[:from_id].to_i != params[:from_id].to_f))
      @response["status"] = 1
      @response["message"] = 'Invaild param : id'
      render :json => @response , status: 400
      return
    end
    if(params.include?('limit') && (params[:limit].to_i.to_s != params[:limit]) || params[:limit].to_i != params[:limit].to_f)
      @response["status"] = 1
      @response["message"] = 'Invaild param : limit'
      render :json => @response , status: 400
      return
    end

    if(params.include?('limit'))
      limit = params[:limit].to_i
    else
      limit = 10
    end
    if(params.include?('from_id'))
      list = Content.getList(params[:from_id].to_i,limit)
    else
      list = Content.getList('',limit)
    end

    @response["status"] = 0
    @response["message"] = 'ok'
    @response["list"] = list
    render :json => @response
  end

  def show
    @response = Hash.new
    if(!Content.exists?(params[:id]))
      @response["status"] = 1
      @response["message"] = "content didn't exist"
      render :json => @response, status: 404
      return
    end

    @content = Content.find(params[:id])
    if(@content.status != 'published')
      @response["status"] = 1
      @response["message"] = "content didn't exist"
      render :json => @response, status: 404
      return
    end
    if(@content.delete_flag != nil)
      @response["status"] = 2
      @response["message"] = "content had been deleted"
      render :json => @response, status: 404
      return
    end

    render :json => Content.getDetail(params[:id])
  end
end
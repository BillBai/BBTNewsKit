class Api::V1::ContentsController < ApplicationController
  protect_from_forgery with: :null_session ＃
  def index
    @response = Hash.new
    if((params.include?('from_id') && !params[:from_id].is_a?(Integer)) && (params.include?('limit') && !params[:id].is_a?(Integer)))
      @response["status"] = 1
      @response["message"] = 'Invaild params'
      render :json => @response
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
      render :json => @response
      return
    end

    @content = Content.find(params[:id])
    render :json => @content
    return

    if(@content.status != 'published')
      @response["status"] = 1
      @response["message"] = "content didn't exist"
      render :json => @response
      return
    end
    if(@content.delete_flag != nil)
      @response["status"] = 2
      @response["message"] = "content had been deleted"
      render :json => @response
      return
    end


  end
end
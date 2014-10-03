class Api::V1::ContentsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @response = Hash.new

    if(params.include?('section_id'))
      if(Section.exists?(params[:section_id]))
        @response["status"] = 0
        @response["message"] = "ok"
        @response["list"] = Content.get_contents_by_section(params[:section_id])
        render :json => @response
      else
        @response["status"] = 1
        @response["message"] = "section didn't exist"
        render :json => @response, status: 400
      end
      return
    end

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
      list = Content.get_list(params[:from_id].to_i,limit)
    else
      list = Content.get_list('',limit)
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

    content = Content.find(params[:id])
    if(content.status != 'published')
      @response["status"] = 1
      @response["message"] = "content didn't exist"
      render :json => @response, status: 404
      return
    end
    if(content.delete_flag)
      @response["status"] = 2
      @response["message"] = "content had been deleted"
      render :json => @response, status: 404
      return
    end

    render :json => content.get_detail
  end
end
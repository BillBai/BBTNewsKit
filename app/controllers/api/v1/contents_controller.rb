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

    if(params.include?('limit') && (params[:limit].to_i.to_s != params[:limit]) || params[:limit].to_i != params[:limit].to_f)
      @response["status"] = 1
      @response["message"] = 'Invaild param : limit'
      render :json => @response , status: 400
      return
    end
    if(params.include?('since_id') && (params[:since_id].to_i.to_s != params[:since_id] || params[:since_id].to_i != params[:since_id].to_f))
      @response["status"] = 1
      @response["message"] = 'Invaild param : since_id'
      render :json => @response , status: 400
      return
    end
    if(params.include?('max_id') && (params[:max_id].to_i.to_s != params[:max_id] || params[:max_id].to_i != params[:max_id].to_f))
      @response["status"] = 1
      @response["message"] = 'Invaild param : max_id'
      render :json => @response , status: 400
      return
    end

    if(params.include?('limit'))
      limit = params[:limit].to_i
      if(limit > 76)
        limit = 76
      end
    else
      limit = 10
    end
    if(params.include?('since_id'))
      since_id = params[:since_id].to_i
    else
      since_id = 0
    end
    if(params.include?('max_id'))
      max_id = params[:max_id].to_i
    else
      max_id = Content.last.id
    end
    list = Content.get_list(limit,max_id,since_id)

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
class Api::V1::ContentsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @response = Hash.new

    # v1/sections/:section_id/contents
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

    # v1/publisher/:publisher_id/contents
    @publisher_id = -1
    if(params.include?('publisher_id'))
      if(params[:publisher_id].to_i.to_s != params[:publisher_id])
        @response["status"] = 1
        @response["message"] = "Invaild publisher id"
        render :json => @response, status: 400
        return
      elsif(Publisher.exists?(params[:publisher_id]))
        @publisher_id = params[:publisher_id]
      else
        @response["status"] = 2
        @response["message"] = "publisher didn't exist"
        render :json => @response, status: 400
        return
      end
    end

    # v1/contents/:content_id/contents
    if(params.include?('content_id'))
      if(params[:content_id].to_i.to_s != params[:content_id])
        @response["status"] = 1
        @response["message"] = "Invaild id"
        render :json => @response, status: 400
      elsif(Content.exists?(params[:content_id]))
        @response["status"] = 0
        @response["message"] = "ok"
        @response["list"] = Content.get_subcontents(params[:content_id])
        render :json => @response
      else
        @response["status"] = 2
        @response["message"] = "content didn't exist"
        render :json => @response, status: 400
      end
      return
    end

    # v1/contents
    if(params.include?('focus') && params[:focus] == 'true' && !params.include?('publisher_id'))
      @response["status"] = 0
      @response["message"] = "ok"
      @response["list"] = Content.get_focus
      render :json => @response
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
      max_id = Content.where(display_on_timeline: true, delete_flag: false ,status: Content.statuses[:published]).last(1)[0].id
    end

    if(@publisher_id != -1)
      list = Content.get_contents_by_publisher(@publisher_id,limit,max_id,since_id)
    else
      list = Content.get_list(limit,max_id,since_id)
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
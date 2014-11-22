class Api::V1::ContentsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @response = Hash.new

    validate_id = Proc.new { |param_name,id,parent|
      if params.include?(param_name)
        if id.to_i.to_s != id
          @response["status"] = 1
          @response["message"] = "Invaild #{param_name}"
          render :json => @response, status: 400
          return
        elsif not parent.exists?(id)
          @response["status"] = 2
          @response["message"] = "#{param_name} didn't exist"
          render :json => @response, status: 400
          return
        else
          id
        end
      else
        nil
      end
    }

    check_parameter = Proc.new{ |name,value|  
      if params.include?(name) && (value.to_i.to_s != value) || value.to_i != value.to_f
        @response["status"] = 1
        @response["message"] = "Invaild parameter : #{name}"
        render :json => @response , status: 400
        return
      end
    }

    # v1/sections/:section_id/contents
    @section_id = validate_id.call('section_id',params[:section_id],Section,@section_id)

    # v1/publishers/:publisher_id/contents
    @publisher_id = validate_id.call('publisher_id',params[:publisher_id],Publisher)

    # v1/contents
    if params.include?('focus') && params[:focus] == 'true' && !params.include?('publisher_id')
      @response["status"] = 0
      @response["message"] = "ok"
      @response["list"] = Content.get_focus
      render :json => @response
      return
    end

    if params.include?('content_type')
      case params[:content_type]
      when "article" then content_type = :article
      when "video" then content_type = :video
      when "album" then content_type = :album
      when "special" then content_type = :special
      else 
        @response["status"] = 3
        @response["message"] = "content_type not exist"
        render :json => @response
        return
      end
    else
      content_type = nil
    end

    check_parameter.call('limit',params[:limit])
    check_parameter.call('since_id',params[:since_id])
    check_parameter.call('max_id',params[:max_id])

    from_max = true
    if params.include?('limit')
      limit = params[:limit].to_i
      if limit > 76
        limit = 76
      end
    else
      limit = 10
    end
    if params.include?('since_id')
      since_id = params[:since_id].to_i
      from_max = false
    else
      since_id = 0
    end
    if params.include?('max_id')
      max_id = params[:max_id].to_i
      from_max = true
    else
      max_id = Content.where(delete_flag: false ,status: Content.statuses[:published]).last(1)[0].id
    end

    case params[:on_focus]
    when "true" then on_focus = true
    when "false" then on_focus = false
    else on_focus = false
    end

    case params[:on_timeline]
    when "true" then on_timeline = true
    when "false" then on_timeline = false
    else on_timeline = true
    end

    if @publisher_id != nil
      list = Content.get_contents_by_publisher(@publisher_id,limit,max_id,since_id,content_type,from_max)
    elsif @section_id != nil
      list = Content.get_contents_by_section(@section_id,limit,max_id,since_id,content_type,from_max)
    else
      list = Content.get_list(limit,max_id,since_id,on_focus,on_timeline,content_type,from_max)
    end
    @response["status"] = 0
    @response["message"] = 'ok'
    @response["list"] = list
    render :json => @response
  end

  def show
    @response = Hash.new
    if not Content.exists?(params[:id])
      @response["status"] = 1
      @response["message"] = "content didn't exist"
      render :json => @response, status: 404
      return
    end

    @content = Content.find(params[:id])
    fresh_when(@content)
    if @content.status != 'published'
      @response["status"] = 1
      @response["message"] = "content didn't exist"
      render :json => @response, status: 404
      return
    end
    if @content.delete_flag
      @response["status"] = 2 
      @response["message"] = "content had been deleted"
      render :json => @response, status: 404
      return
    end

    render :json => @content.get_detail
  end

  def subcontents
    @response = Hash.new

    if params[:id].to_i.to_s != params[:id]
      @response["status"] = 1
      @response["message"] = "Invaild id"
      render :json => @response, status: 400
    elsif Content.exists?(params[:id])
      @response["status"] = 0
      @response["message"] = "ok"
      @response["list"] = Content.get_subcontents(params[:id])
      render :json => @response
    else
      @response["status"] = 2
      @response["message"] = "content didn't exist"
      render :json => @response, status: 400
    end
    return
  end
end
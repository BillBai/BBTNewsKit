class Api::V1::ContentsController < ApplicationController
  def index
    @message = Message.new

    if((params.include?('from_id') && !params[:from_id].is_a?(Integer)) && (params.include?('limit') && !params[:id].is_a?(Integer)))
      @message.setStatus(1)
      @message.setMessage('Invaild params')
      render :json => @message
      return
    end

    if(params.include?('limit'))
      @limit = params[:limit].to_i
    else
      @limit = 10
    end

    if(params.include?('from_id'))
      @temp = ListMaker.new(params[:from_id].to_i,@limit)
    else
      @temp = ListMaker.new('',@limit)
    end

    @message.setStatus(0)
    @message.setMessage('ok')
    @message.setList(@temp.getList)
    render :json => @message
  end
end

class Message
  def initialize
    @status = nil
    @message = ''
    @list = nil
  end

  def setStatus(status)
    @status = status
  end

  def setMessage(message)
    @message = message
  end

  def setList(list)
    @list = list
  end
end

class ListMaker
  def initialize(from_id,limit)
    @had_from_id = false
    if(from_id == '')
      @from_id = Content.last.id
    else
      @had_from_id = true
      @from_id = from_id
    end

    @count = 0
    @from_id_count = 0
    @id = @from_id
    @list = Array.new
    loop do
      @temp = RequestContent.new(@id)
      if (@temp.exist?)
        @temp.clear
        @list << @temp
        @count = @count + 1
      end
      @from_id_count = @from_id_count + 1
      @id = @id - 1
      break if (@id < 0 || @count == limit  || (@had_from_id && @from_id_count == limit))
    end
  end

  def getList()
    return @list
  end
end

class RequestContent
  def initialize(id)
    @exist = true
    if(Content.exists?(id))
      @temp = Content.find(id)
      if(@temp.status == 'published' && @temp.delete_flag == nil)
        @id = @temp.id
        @content_type = @temp.content_type
        @created_at = @temp.created_at
        @updated_at = @temp.updated_at
        @title = @temp.title
        @subtitle = @temp.subtitle
        @description = @temp.description
        @author_id = @temp.author_id
        @section_id = @temp.section_id
        @trumb_image_url = nil
      else
        @exist = false
      end
      remove_instance_variable(:@temp)
    else
      @exist = false
    end
  end
  
  def exist?
    return @exist
  end
  
  def clear
    remove_instance_variable(:@exist)
  end
end	
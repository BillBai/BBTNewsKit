module ContentsHelper

  def status_label(content, label_text)
    if content.draft?
      "<span class='label label-default'>#{label_text}</span>"
    elsif content.published?
      "<span class='label label-success'>#{label_text}</span>"
    end
  end

  def content_type_label(content, label_text)
    if content.article?
      "<span class='label label-info'><span class='glyphicon glyphicon-file'></span>    #{label_text}</span>"
    elsif content.album?
      "<span class='label label-info'><span class='glyphicon glyphicon-picture'></span>    #{label_text}</span>"
    elsif content.video?
      "<span class='label label-info'><span class='glyphicon glyphicon-facetime-video'>   </span>    #{label_text}</span>"
    end
  end

end

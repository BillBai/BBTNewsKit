module ContentsHelper
  require 'nokogiri'
  def status_label(content, label_text)
    if content.draft?
      "<span class='label label-default label-lg'>#{label_text}</span>"
    elsif content.published? || content.approved?
      "<span class='label label-success'>#{label_text}</span>"
    elsif content.pending?
      "<span class='label label-warning'>#{label_text}</span>"
    elsif content.rejected?
      "<span class='label label-danger'>#{label_text}</span>"
    end
  end

  def content_type_label(content, label_text)
    if content.article?
      "<span class='label label-info'><span class='glyphicon glyphicon-file'></span>    #{label_text}</span>"
    elsif content.album?
      "<span class='label label-danger'><span class='glyphicon glyphicon-picture'></span>    #{label_text}</span>"
    elsif content.video?
      "<span class='label label-warning'><span class='glyphicon glyphicon-facetime-video'>   </span>    #{label_text}</span>"
    elsif content.special?
      "<span class='label label-success'><span class='glyphicon glyphicon-star'>   </span>    #{label_text}</span>"
    end
  end

  def focus_label(content)
    if content.on_focus?
      "<span class='label label-warning'>" + t("focus") + "</span>"
    else
      ""
    end
  end

  def get_mobile_html(html_string)
    html_doc = Nokogiri::HTML(html_string)
    html_doc.css("img").each do |img|
      img["style"] = "width:100%"
    end
    return html_doc.to_html
  end

  def get_mobile_video_html(html_string)
    html_doc = Nokogiri::HTML(html_string)
    html_doc.css("img").each do |img|
      img["style"] = "width:100%"
    end
    html_doc.css("iframe").each do |iframe|
      iframe["width"] = "100%"
      iframe["style"] = "height:9rem;margin-top:0.714rem"
    end
    return html_doc.to_html
  end

  def get_video_id(url)
    if url =~ URI::regexp
      uri = URI.parse(url)
      return /\/id_(.*)\.html/.match(uri.path)[1]
    else
      return ""
    end
  end

  def update_html_info(html_string,views,like)
    html_doc = Nokogiri::HTML(html_string)
    html_doc.css("#views").each do |each|
      each.inner_html = "有#{views}个路人来过"
    end
    html_doc.css("#like").each do |each|
      each.inner_html = "收到#{like}个赞"
    end
    return html_doc.to_html
  end
end

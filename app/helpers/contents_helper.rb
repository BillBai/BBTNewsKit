module ContentsHelper

  def status_label(content, label_text)
    if content.draft?
      "<span class='label label-default'>#{label_text}</span>"
    elsif content.published?
      "<span class='label label-success'>#{label_text}</span>"
    end
  end

end

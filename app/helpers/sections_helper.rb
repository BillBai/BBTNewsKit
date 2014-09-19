module SectionsHelper
  def section_selection_field_dict
    sections = Section.all
    dict = {}
    sections.each do |section|
      dict["#{section.category}-#{section.module}"] = section.id
    end

    dict
  end
end

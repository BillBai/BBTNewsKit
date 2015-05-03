class AddHtmlTemplateToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :template_html, :string
  end
end

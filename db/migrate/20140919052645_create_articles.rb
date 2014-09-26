class CreateArticles < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :body_html_url

      t.timestamps
    end
  end
end

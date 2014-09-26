class AddVideoUrlToContent < ActiveRecord::Migration
  def change
    add_column :contents, :video_url, :string
  end
end

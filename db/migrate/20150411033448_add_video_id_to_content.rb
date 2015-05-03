class AddVideoIdToContent < ActiveRecord::Migration
  def change
  	add_column :contents, :video_id, :string
  end
end

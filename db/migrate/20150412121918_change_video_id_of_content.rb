class ChangeVideoIdOfContent < ActiveRecord::Migration
  def change
  	change_column :contents, :video_id, :string, default: ""
  end
end

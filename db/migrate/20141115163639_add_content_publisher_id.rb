class AddContentPublisherId < ActiveRecord::Migration
  def change
    add_column :contents, :publisher_id, :integer
  end
end

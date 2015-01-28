require_relative '20141115165036_add_attr_to_publisher'
require_relative '20141115163639_add_content_publisher_id'
require_relative '20141115151637_create_publishers.rb'

class FixupPublisher < ActiveRecord::Migration
  def change
  	revert AddAttrToPublisher
  	revert AddContentPublisherId
  	revert CreatePublishers
  end
end

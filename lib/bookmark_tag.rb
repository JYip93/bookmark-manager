require_relative 'database_connection.rb'

class Bookmark_tag
  attr_reader :bookmark_id, :tag_id 
  def initialize(bookmark_id, tag_id)
    @bookmark_id = bookmark_id
    @tag_id = tag_id
  end

  def self.create(bookmark_id, tag_id)
    result = DatabaseConnection.query("INSERT into bookmark_tags (bookmark_id, tag_id) VALUES ('#{bookmark_id}', '#{tag_id}') RETURNING bookmark_id, tag_id;")
    Bookmark_tag.new(result[0]['bookmark_id'], result[0]['tag_id'])
  end 
end
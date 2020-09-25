require_relative 'database_connection.rb'
require_relative 'comment.rb'
require_relative 'bookmark_tag.rb'
class Bookmark

  attr_reader :title, :url, :id

  def initialize(title, url, id)
    @title = title
    @url = url
    @id = id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map { |bookmark| Bookmark.new(bookmark['title'], bookmark['url'], bookmark['id']) }
  end

  def self.create(title, url)
    return false unless Bookmark.check_url(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks(title, url) VALUES('#{title}', '#{url}') RETURNING id, title, url ;")
    Bookmark.new(result[0]['title'], result[0]['url'], result[0]['id'])
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id};")
  end

  def self.update(id, title, url)
    result = DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}', url = '#{url}' where id = '#{id}' RETURNING id, title, url ;")
    Bookmark.new(result[0]['title'], result[0]['url'], result[0]['id'])
  end 

  def comments
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{@id}")
    result.map {|comment| Comment.new(comment['id'], comment['text'], comment['bookmark_id'])}
  end 

  def getting_tag_names
    result = DatabaseConnection.query("SELECT * FROM bookmark_tags WHERE bookmark_id = #{@id}")
    bookmark_tags = result.map {|tag| Bookmark_tag.new(tag['bookmark_id'], tag['tag_id'])}
    array_of_tag_ids = []
    bookmark_tags.each do |bookmark_tags|
      array_of_tag_ids << bookmark_tags.tag_id
    end 
    array_of_tag_names = []
    array_of_tag_ids.each do |tag_ids|
      result2 = DatabaseConnection.query("SELECT content FROM tags WHERE id = #{tag_ids}")
      array_of_tag_names << result2[0]['content']
    end 
    array_of_tag_names
  end

  private

  def self.check_url(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end 

end
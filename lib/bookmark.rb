require_relative 'database_connection.rb'

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

  private

  def self.check_url(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end 

end
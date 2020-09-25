require_relative 'database_connection.rb'

class Tag
  attr_reader :id, :content
  def initialize(id, content)
    @id = id
    @content = content    
  end

  def self.create(content)
    result = DatabaseConnection.query("INSERT into tags (content) VALUES('#{content}') RETURNING id, content;")
    Tag.new(result[0]['id'], result[0]['content'])
  end
end
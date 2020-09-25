require 'database_connection'
require 'bookmark_tag'
require 'tag'
require 'bookmark'
describe Bookmark_tag do
  describe '.create' do
    it 'assigns a bookmark a tag in the bookmark tags DB' do
      bookmark = Bookmark.create('Test', "http://www.test.com")
      tag = Tag.create("Test Tag")
      bookmark_tag = Bookmark_tag.create(bookmark.id, tag.id)
      expect(bookmark_tag.tag_id).to eq tag.id 
    end
  end
end
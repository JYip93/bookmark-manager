require 'bookmark'
require 'comment'

describe Comment do
  describe '#create' do
    it 'adds a comment to example bookmark' do
      bookmark = Bookmark.create('Test', "http://www.test.com")
      comment_obj = Comment.create(bookmark.id, "this is a test comment")
      expect(comment_obj.text).to eq("this is a test comment")
    end
  end
end
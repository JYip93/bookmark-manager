require 'bookmark'
describe Bookmark do

  let(:title) { 'Test' }
  let(:url) { 'www.test.com' }
  let(:id) {1}

  it 'takes a title and url on initialisation' do
    expect(Bookmark).to respond_to(:new).with(3).arguments
  end

  it 'stores the title given' do
    bookmark = Bookmark.new(title, url, id)
    expect(bookmark.title).to eq title
  end

  it 'stores the url given' do
    bookmark = Bookmark.new(title, url, id)
    expect(bookmark.url).to eq url
  end

  describe '#all' do
    it 'Returns a list of bookmarks when .all is called' do
      expect(Bookmark.all).to eq []
    end
  end
  describe '#create' do
    it 'Adds a new bookmark url' do
      Bookmark.create('Test', "http://www.test.com")
      expect(Bookmark.all[0].url).to eq('http://www.test.com')
    end

    it 'Adds the new bookmark title' do
      Bookmark.create('Test', "http://www.test.com")
      expect(Bookmark.all[0].title).to include('Test')
    end

    it 'if user adds invalid url expect .all to be empty' do
      Bookmark.create('Test', "ohoh.test.com")
      expect(Bookmark.all.length).to eq 0
    end 

  end

  describe '#delete' do
    it 'Delete a bookmark from bookmark page' do
      bookmark = Bookmark.create('Test', "http://www.test.com")
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '#update' do
    it 'updates an existing bookmark' do
      bookmark = Bookmark.create('Test', "http://www.test.com")
      Bookmark.update(bookmark.id, 'makers', 'http://makers.co.uk')
      expect(Bookmark.all[0].title).to eq('makers')
      expect(Bookmark.all[0].url).to eq('http://makers.co.uk')
    end 

  end 

  # describe '#comment' do 
  #   it 'adds a comment to a bookmark' do 
  #     bookmark = Bookmark.create('Test', "http://www.test.com")
  #     Bookmark.comment(bookmark.id, "this is a test comment")
  #     expect(Bookmark.all[0].comment).to eq("this is a test comment")
  #   end
  # end 


end
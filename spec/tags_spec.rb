require 'database_connection'
require 'tag'
describe Tag do 
  describe '.create' do
    it 'creates Tag and returns tag object' do
      tag = Tag.create("Search Engine")
      expect(tag.content).to eq("Search Engine")
    end 
  end
end 
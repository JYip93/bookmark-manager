feature 'Update Bookmark bookmark' do
  scenario 'user updates an existing bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.google.com', 'Google');")
      visit('/')
      click_button('Update')
      fill_in('title', with: "makers")
      fill_in('url', with: "http://makers.co.uk")
      click_button("Submit")
      expect(page).to have_link("makers",href:"http://makers.co.uk")
  end
end
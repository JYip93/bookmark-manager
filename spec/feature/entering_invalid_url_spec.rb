feature 'validation of bookmark url' do 
  scenario 'users trys adding a bookmark with a invalid url' do
    visit('/')
    click_link("Add Bookmark")
    fill_in 'title', with: 'ABC'
    fill_in 'url', with: 'w.w.ww.abc.com'
    click_button 'Submit'
    expect(page).to have_content "Invalid URL enter correct url"
  end

end 
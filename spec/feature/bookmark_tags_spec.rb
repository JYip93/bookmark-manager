feature 'Create tag' do
    scenario 'Create a tag and view it in the bookmark page' do
        Bookmark.create('Google','http://google.com')
        visit ('/')
        click_button('Add tag')
        fill_in('Tag', with: 'Search engine')
        click_button('Submit')
        expect(page).to have_content('Search engine')
    end
end
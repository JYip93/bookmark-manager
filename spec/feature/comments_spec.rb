feature '#comments' do
    scenario 'Click comment from bookmark page and be able to add comment' do
        Bookmark.create('Google','http://google.com')
        visit('/')
        click_button('Add Comment')
        fill_in('Comment', with: 'This is a comment')
        click_button('Submit')
        expect(page).to have_content('This is a comment')
    end
end
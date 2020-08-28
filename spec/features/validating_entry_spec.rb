feature 'Validating entry' do
  scenario 'will validate a users entry' do
    visit '/bookmarks'
    fill_in :title, with: 'Test'
    fill_in :url, with: 'wqw.test.com'
    click_button 'Add'
    expect(page).to have_content "You must submit a valid URL."
    expect(page).not_to have_link('Test', href: 'wqw.test.com')
  end
end
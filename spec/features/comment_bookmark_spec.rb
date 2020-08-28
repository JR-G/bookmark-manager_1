feature "User can add comments to the bookmars" do 
  scenario "user write a comment" do 
    bookmark = Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit("/bookmarks")
    #within("#login_form"){ fill_in("user_email", with: "foo@example.com")} 
    fill_in("comment", with: "My first comment") 
    first('.bookmark').click_button 'Post'
    expect(page).to have_content "My first comment"
  end
end
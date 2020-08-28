require 'bookmarks'
require 'database_helpers'

describe Bookmarks do

  describe '#.all' do
    it 'returns all bookmarks stored in class' do

      con = PG.connect :dbname => 'bookmark_manager_test'

      bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers")
      Bookmarks.create(url: "http://www.destroyallsoftware.com", title: "DestroySoftware")
      Bookmarks.create(url: "http://www.google.com", title: "Google")
     
      bookmarks = Bookmarks.all
      
     
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmarks
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '#.create' do
    it 'adds a bookmark to database' do

      bookmark = Bookmarks.create( url:'http://www.test.com', title: 'Test')
      persisted_data = persisted_data(id: bookmark.id)
     
      expect(bookmark).to be_a Bookmarks
     expect(bookmark.id).to eq persisted_data['id']
    expect(bookmark.title).to eq 'Test'
    expect(bookmark.url).to eq 'http://www.test.com'

    end
  end

  describe '#.delete' do 
    it 'deletes a bookmark from the database' do
      bookmark = Bookmarks.create( url:'http://www.test.com', title: 'Test')

      Bookmarks.delete(id: bookmark.id)
      expect(Bookmarks.all.length).to eq 0
    end
  end
  
  describe '#.update' do
    it 'updates a bookmark' do
      bookmark = Bookmarks.create( url:'http://www.tast.com', title: 'Test')

      book = Bookmarks.update(url: 'http://www.test.com', title: 'Test', id: bookmark.id )
      expect(book.url).to eq 'http://www.test.com'
    end
  end

  describe '#find' do 
    it 'finds the bookmark to be updated' do
      bookmark = Bookmarks.create( url:'http://www.tast.com', title: 'Test')

      book = Bookmarks.find( id: bookmark.id )
      expect(book.id).to eq bookmark.id
    end
  end
end

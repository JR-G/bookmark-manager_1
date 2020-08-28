require_relative 'database_connection'

class Bookmarks

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end

  def self.all
    bookmarks = DatabaseConnection.query("SELECT * FROM bookmarks")
    bookmarks.map do |bookmark|
      Bookmarks.new(
        id: bookmark['id'], title: bookmark['title'], url: bookmark['url']
      )
    end
  end

  def self.create(url:, title:)
    return false unless validate?(url)

    bookmarks =  DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;")
    Bookmarks.new(id: bookmarks[0]['id'], title: bookmarks[0]['title'], url: bookmarks[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(url:, title:, id:)
    js =  DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmarks.new(id: js[0]['id'], url: js[0]['url'], title:js[0]['title'])
  end

  def self.find(id:)
    js =  DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmarks.new(id: js[0]['id'], url: js[0]['url'], title:js[0]['title'])
  end

  private

  def self.validate?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end

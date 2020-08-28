require 'pg'
def setup_test_database
  con = PG.connect :dbname => 'bookmark_manager_test'

  con.exec "TRUNCATE bookmarks, comments RESTART IDENTITY;"
end
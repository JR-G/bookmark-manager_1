require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmarks'
require_relative './database_setup.rb'
require 'uri'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do

    @bookmarks = Bookmarks.all
    erb :bookmarks
  end

  post '/add' do
      flash[:notice] = "You must submit a valid URL." unless Bookmarks.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmarks.delete( id: params['id'])
    redirect '/bookmarks'
    
  end

  get '/bookmarks/:id/update' do
    @bookmark = Bookmarks.find( id: params[:id])

    erb :bookmarks_update
   
  end

  patch '/bookmarks/:id' do
    Bookmarks.update(url: params['url'], title: params['title'], id: params[:id])
    redirect '/bookmarks'
  end

  

  run! if app_file == $0

end

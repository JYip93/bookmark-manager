require 'sinatra/base'
require_relative './lib/bookmark'



class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/bookmarks/new' do
    erb :"/bookmarks/new"
  end

  post '/bookmarks' do
    Bookmark.create(params[:title], params[:url])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/edit/:id' do
    @id = params[:id]
    erb :update
  end 

  patch '/bookmarks/:id' do 
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/bookmarks'
  end 

  run! if app_file == $0

end
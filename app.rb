require 'sinatra/base'
require_relative './lib/bookmark'
require_relative './lib/comment'
require_relative 'database_connection_setup'
require 'sinatra/flash'
require 'uri'


class BookmarkManager < Sinatra::Base
  database_setup
  enable :sessions, :method_override
  register Sinatra::Flash

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
    flash[:notice] = "Invalid URL enter correct url" unless Bookmark.create(params[:title], params[:url]) 
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

  get '/bookmarks/comments/:id' do
    @id = params[:id]
    erb :comments
  end

  post '/bookmarks/:id/comments' do
    Comment.create(params[:id], params[:Comment])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
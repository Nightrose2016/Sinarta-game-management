class GamesController < ApplicationController

  # GET: /games
  get "/games" do
    erb :"/games/index"
  end

  # GET: /new
  get "/new" do
    erb :'games/new'
  end

  post '/games/new' do
    games = Games.new(:name => params[:name], :genre => params[:genre], :developer => params[:developer], :publisher => params[:publisher])
    if games.save
      redirect to('/games')
    else
      redirect to('/new')
    end

  end

  get "/library" do
    erb :"games/library"
  end

  # POST: /games
  post "/games" do
    redirect "/games"
  end

  # GET: /games/5
  get "/games/:id" do
    erb :"/games/show.html"
  end

  # GET: /games/5/edit
  get "/games/:id/edit" do
    erb :"/games/edit.html"
  end

  # PATCH: /games/5
  patch "/games/:id" do
    redirect "/games/:id"
  end

  # DELETE: /games/5/delete
  delete "/games/:id/delete" do
    redirect "/games"
  end
end
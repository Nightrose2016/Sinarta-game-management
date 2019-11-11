class GamesController < ApplicationController

  # GET: /games
  get "/games" do
    erb :"/games/index"
  end

  # GET: /new
  get "/recipes/new" do
    @users = Users.all
    erb :"games/new"
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
    @games = Games.all
    erb :"games/library"
  end

  # POST: /games
  post "/games" do
    redirect "/games"
  end

  # GET: /games/5
  get "/games/:id" do
    erb :"/games/show"
  end

  # GET: /games/5/edit
  get "/games/:id/edit" do
    @games = Games.find_by_id(params[:id])
    if @games.user_id == current_user.id
      erb :"games/edit"
    else
      redirect "/games"
  end
  end

  # PATCH: /games/5
  patch "/games/:id" do
    @games = Games.find_by_id(params[:id])
    params.delete("_method")
    if @games.user.id == current_user.id && @games.update(name: params[:name], genre: params[:genre], publisher: params[:publisher], developer: params[:developer], user_id: current_user.id)
      redirect "/games/#{@games.id}"
    else
      redirect "/games/#{@games.id}/edit"
    end
  end

  # DELETE: /games/5/delete
  delete "/recipes/:id" do
    @games = Games.find_by_id(params[:id])
    if @games.user.id == current_user.id
      @games.destroy
      redirect "/games"
    else
      redirect "/games"
    end
  end
end
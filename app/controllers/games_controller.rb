class GamesController < ApplicationController

  get "/games" do
    if logged_in?
      @games = Games.all
      erb :"games/index"
    # else
    #   erb :"/sessions/error" #plan on adding errors later
    end
  end

  post "/games" do
    @games = current_user.games.build(name: params[:name], genre: params[:genre], publisher: params[:publisher], developer: params[:developer])
    if @games.save
      redirect "/games/#{@games.id}"
    else
      redirect "/games/new"
    end
  end

  get "/games/new" do
    @users = Users.all
    erb :"games/new"
  end

  post '/games/new' do
    @games = Games.new(:name => params[:name], :genre => params[:genre], :developer => params[:developer], :publisher => params[:publisher])
    if games.save
      redirect to('/games')
    else
      redirect to('/new')
    end
  end

  get "/games/:id" do
    @games = Games.find_by_id(params[:id])
    if @games.user_id == current_user.id
      erb :"games/show"
    else
      redirect "/games/index"
    end
  end

  patch "/games/:id" do
    @games = Games.find_by_id(params[:id])
    params.delete("_method")
    if @games.user.id == current_user.id && @games.update(name: params[:name], genre: params[:genre], publisher: params[:publisher], developer: params[:developer], user_id: current_user.id)
      redirect "/games/#{@games.id}"
    else
      redirect "/games/#{@games.id}/edit"
    end
  end

  delete "/games/:id" do
    @games = Games.find_by_id(params[:id])
    if @games.user.id == current_user.id
      @games.destroy
      redirect "/games"
    else
      redirect "/games"
    end
  end

  get "/games/:id/edit" do
    @games = Games.find_by_id(params[:id])
    if @games.user_id == current_user.id
      erb :"games/edit"
    else
      redirect "/games"
    end
  end
end
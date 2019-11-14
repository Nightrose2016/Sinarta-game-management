class GamesController < ApplicationController

  get "/games" do
    if logged_in?
      # binding.pry
      @games = current_user.games.all
      erb :"games/index"
    else
      erb :"/users/signin"
    end
  end

  post "/games" do
    @games = current_user.games.build(name: params[:name], genre: params[:genre], publisher: params[:publisher], developer: params[:developer], user_id: current_user.id)
    if @games.save
      redirect "/games/#{@games.id}"
    else
      redirect "/games/new"
    end
  end

  get "/games/new" do
    @users = User.all
    erb :"games/new"
  end

  post '/new' do
    @games = Game.new(:name => params[:name], :genre => params[:genre], :developer => params[:developer], :publisher => params[:publisher], user_id: current_user.id)
    # binding.pry
    if @games.save
      redirect to('/games')
    else
      redirect to('/new')
    end

  end

  get "/games/:id" do
    @games = Game.find_by_id(params[:id])
    # binding.pry
    if @games.user_id == current_user.id
      erb :"games/show"
    else
      redirect "/games/index"
    end
  end

  post '/games/:id' do
    # binding.pry
    @games = Game.find_by_id(params[:id])
    params.delete("_method")
    if @games.user_id == current_user.id && @games.update(name: params[:name], genre: params[:genre], publisher: params[:publisher], developer: params[:developer], user_id: current_user.id)
      
      redirect "/games/#{@games.id}"
    else
      redirect "/games/#{@games.id}/edit"
    end
  end

  # patch "/games/:id" do
  #   binding.pry
  #   @games = Games.find_by_id(params[:id])
  #   params.delete("_method")
  #   if @games.user.id == current_user.id && @games.update(name: params[:name], genre: params[:genre], publisher: params[:publisher], developer: params[:developer], user_id: current_user.id)
      
  #     redirect "/games/#{@games.id}"
  #   else
  #     redirect "/games/#{@games.id}/edit"
  #   end
  # end

  delete "/games/:id" do
    @games = Game.find_by_id(params[:id])
    if @games.user_id == current_user.id
      @games.destroy
      redirect "/games"
    else
      redirect "/games"
    end
  end

  get "/games/:id/edit" do
    @games = Game.find_by_id(params[:id])
    if @games.user_id == current_user.id
      erb :"games/edit"
    else
      redirect "/games"
    end
  end
end
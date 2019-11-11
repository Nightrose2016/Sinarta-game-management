class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to'/games'
    end
  end

  post '/signup' do
    user = Users.new(:username => params[:username], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect to('/login')
    else
      redirect to('/signup')
    end
  end
    
  get '/login' do
    if !logged_in?
      erb :'users/signin'
    else
      redirect to('/games')
    end
  end

  post '/login' do
    user = Users.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to('/games')
    else
      redirect to('/login')
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end  

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
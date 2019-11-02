class UsersController < ApplicationController
    
    get '/signup' do
        if !logged_in?
          erb :'users/signup'
        else
          redirect to '/games'
        end
    end

    post '/signup' do
        user = User.new(params)
        if user.save
            session[:user_id] = user.id
            redirect to('/games')
        else
            redirect to('/signup')
        end
    end
    
    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to('/games')
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to('/tweets')
        else
            redirect to('/login')
        end
    end
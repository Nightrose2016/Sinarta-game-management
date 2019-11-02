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
    
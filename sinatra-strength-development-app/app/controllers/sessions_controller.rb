class SessionsController < ApplicationController



get '/login' do 
    if !logged_in?
      
        erb :'sessions/login'
      else 
      redirect "/users/#{current_user.id}"
      end 
    end 

    post '/login' do 
      
      user = User.find_by(username: params[:username])
      if params[:username].empty? ||  params[:password].empty?
        redirect '/login'
      end 
      
      if !user
       
       redirect "users/signup"
       
      elsif user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{current_user.id}"
       
      end 
    
    end

end
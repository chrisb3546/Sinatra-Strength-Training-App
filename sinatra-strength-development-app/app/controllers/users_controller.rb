class UsersController < ApplicationController
  
   
    get '/users' do 
        erb :'users/index'
    end
    
    get '/users/:id' do 
             if logged_in?
                @user = User.find(params[:id])
                erb :'users/show'
            else
                redirect '/login'
             end 
    end

    get '/logout' do 
        session.clear
        redirect '/login'
    end 

 end 
        
 
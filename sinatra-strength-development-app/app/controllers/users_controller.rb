class UsersController < ApplicationController
  
   
    get '/signup' do
        if logged_in?
           redirect "/lifts"
          else 
            erb :'users/signup'
            
            
        end 
    end
    
    post '/signup' do 
        
      @user = User.new(:username => params[:username], :email => params[:email],:password => params[:password])
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          
          redirect '/signup'
       
          
        end
       
        if @user.save
          session[:user_id] = @user.id
          redirect "/users/#{current_user.id}"
        else 
          redirect '/signup'
        end 
      end

    get '/users/:id' do 
             if logged_in? 
                @user = User.find(params[:id])
                erb :'users/show'
            else
                redirect '/login'
             end 
    end

    get '/users/:username' do 
        @user = User.find(params[:username])
        erb :'users/show'
    end

    get '/logout' do 
        session.clear
        redirect '/login'
    end 

 end 
        
 
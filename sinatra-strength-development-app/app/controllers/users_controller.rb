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
          redirect '/users/:id'
        end 
      end
    


    get '/login' do 
        if !logged_in?
          
            erb :'users/login'
          else 
          redirect "/lifts"
          end 
        end 

    post '/login' do 
        @user = User.find_by(username: params[:username])
      if params[:username].empty? ||  params[:password].empty?
        redirect '/login'
      end 
      
      if !@user.authenticate(params[:password])
       
       redirect "/signup"
       
      elsif @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/:id"
       
      end 

    end
      
    
        get '/users/:id' do 
            if logged_in?
                @user = User.find_by(id: params[:id])
                erb :'users/show'
            else
                redirect '/login'
            end 
        end


    end 
        
 
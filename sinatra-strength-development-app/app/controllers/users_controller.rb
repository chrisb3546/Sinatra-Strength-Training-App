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
            flash.next[:message]= "ONE OR MORE FIELDS WITH EMPTY OR INVALID INFORMATION"
           
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
             if logged_in? && @user = User.find_by(id: params[:id])
                erb :'users/show'
             elsif !@user
                redirect '/'
             else
                redirect '/login'
            end 
        end

    get '/users/:username' do 
        if logged_in? && @user = User.find(params[:username])
        erb :'users/show'
        elsif !@user
        redirect '/'
        else
        redirect '/login'
        end 
    end


    get '/logout' do 
        session.clear
        redirect '/login'
    end 

 end 
        
 
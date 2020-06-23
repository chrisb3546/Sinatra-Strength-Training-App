require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "strengthapp"
  end

  get '/' do
    if logged_in?
      redirect "users/#{current_user.id}"
    else 
    erb :'index'
    end 
    
  end 

 

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
    end 
  end



get '/login' do 
    if !logged_in?
      
        erb :'users/login'
      else 
      redirect "/users/#{current_user.id}"
      end 
    end 

    post '/login' do 
      
      @user = User.find_by(username: params[:username])
      if params[:username].empty? ||  params[:password].empty?
        redirect '/login'
      end 
      
      if !@user.authenticate(params[:password])
       
       redirect "users/signup"
       
      elsif @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{current_user.id}"
       
      end 
    
    end


helpers do 

  def logged_in?
    !!current_user
  end

  def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end 

  def current_lift
    if logged_in?
      @current_lift == Lift.find_by(id: params[:id])
    end
  end
  


end



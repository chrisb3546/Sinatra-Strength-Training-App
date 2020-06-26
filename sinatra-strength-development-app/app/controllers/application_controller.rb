require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch("SECRET")
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      redirect "users/#{current_user.id}"
    else 
    erb :'welcome'
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



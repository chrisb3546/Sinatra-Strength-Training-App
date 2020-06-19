require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if logged_in?
      redirect "users/#{current_user}"
    else 
    erb :'users/index'
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
  


end

end

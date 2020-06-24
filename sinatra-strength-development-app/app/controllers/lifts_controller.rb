class LiftsController < ApplicationController
   
    get '/lifts' do
        
            erb :'users/show'
    end 
    

    get '/lifts/new' do 
        if logged_in?
         erb :'lifts/new'
     else 
         redirect '/'
        end
    end 

    post '/lifts' do 
        if params[:name].empty? || params[:weight].empty? || params[:repetitions].empty?
            redirect 'lifts/new'
        else
       lift = Lift.new(username: current_user.username, name: params[:name], user_id: current_user.id, weight: params[:weight], repetitions: params[:repetitions])
       lift.save
       redirect "/lifts/#{lift.id}"
     
       
        
    end 
      
    end

    get '/lifts/:id' do 
        if logged_in?

        @lift = Lift.find_by(user_id: params[:id])
        erb :'lifts/show'
        else
            redirect '/login'
    end
end
    get '/lifts/:id/edit' do
        if !logged_in?
          redirect to '/login'
        end
        @lift = Lift.find(params[:id])
        if @lift.user_id == current_user.id
            erb :'/lifts/edit'
        else
          redirect to '/login'
        end
      end

      patch '/lifts/:id' do
        @lift = Lift.find(params[:id])
    
        if params[:name].empty? || params[:weight].empty? || params[:repetitions].empty?
          redirect to "/lifts/#{@lift.id}/edit"
        end
    
        @lift.update(name: params["name"], weight: params["weight"], repetitions: params["repetitions"])
        @lift.save
        redirect to "/lifts/#{@lift.id}"
    
      end

      delete '/lifts/:id' do
        if !logged_in?
            redirect to '/login'
        else
            @lift = Lift.find(params[:id])
            @lift.destroy
            redirect to '/lifts'
        end
      end


end
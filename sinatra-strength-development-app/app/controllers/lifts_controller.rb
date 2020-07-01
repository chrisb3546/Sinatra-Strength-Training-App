class LiftsController < ApplicationController
   
    get '/lifts' do
        redirect_if_not_logged_in
        @user = current_user
        erb :'users/show'
    end 
    

    get '/lifts/new' do 
        redirect_if_not_logged_in
        erb :'lifts/new'
    end 

    post '/lifts' do 
        if params[:name].empty? || params[:weight].empty? || params[:repetitions].empty?
            flash.next[:message]= "ONE OR MORE FIELDS WITH EMPTY OR INVALID INFORMATION"
            redirect 'lifts/new'
        else
            @lift = Lift.create(name: params[:name], user_id: current_user.id, weight: params[:weight], repetitions: params[:repetitions])
            @lift.save
            redirect "/lifts/#{@lift.id}"
        end 
    end

    get '/lifts/:id' do 
        redirect_if_not_logged_in
        if @lift = Lift.find_by(id: params[:id])
            erb :'lifts/show'
        elsif !@lift = Lift.find_by(id: params[:id])
    
            redirect 'lifts/new'
        end
    end
    
    get '/lifts/:id/edit' do
        redirect_if_not_logged_in
        @lift = Lift.find_by(id: params[:id]) 
        if !@lift
            redirect '/lifts'
        end
        if  @lift && current_user == @lift.user
            erb :'/lifts/edit'
        else
          redirect to '/login'
        end
    end

    patch '/lifts/:id' do
        redirect_if_not_logged_in
        @lift = Lift.find(params[:id])
        
        if params[:name].empty? || params[:weight].empty? || params[:repetitions].empty?
            flash.next[:message]= "ONE OR MORE FIELDS WITH EMPTY OR INVALID INFORMATION"
            redirect to "/lifts/#{@lift.id}/edit"
        end

        if @lift && current_user == @lift.user
            @lift.update(name: params["name"], weight: params["weight"], repetitions: params["repetitions"])
            @lift.save
            redirect to "/lifts/#{@lift.id}"
        else 
            redirect '/lifts'
        end  
    end

    delete '/lifts/:id' do
        redirect_if_not_logged_in
        @lift = Lift.find_by(id: params[:id])
        if !@lift
            redirect '/lifts'
        end
        if @lift && current_user == @lift.user
            @lift.destroy
            redirect to '/lifts'
        end
    end 


end
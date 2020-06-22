class CreateLifts < ActiveRecord::Migration
    def change 
        create_table :lifts do |t|
            t.string :username
            t.string :name
            t.integer :user_id
            t.integer :weight
            t.integer :repetitions
        end 
     end
end 

class CreateLifts < ActiveRecord::Migration
    def change 
        create_table :lifts do |t|
            t.string :username
            t.string :lift_name
            t.integer :user_id
        end 
     end
end 

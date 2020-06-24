class User < ActiveRecord::Base
    has_secure_password
    has_many :lifts
    validates :email, uniqueness: true
    validates :username, uniqueness: true
    
  end
class Plan < ActiveRecord::Base
    # Pro plan and basic plan can have many users
    has_many :users 
end
class UsersController < ApplicationController
    before_action :authenticate_user!
    
    # GET to /users(.:format)        
    def index
        # It limits amount of queries over User.all
        @users = User.includes(:profile)
    end
    
    # GET to /users/:id
    def show
        @user = User.find( params[:id] )
    end
end
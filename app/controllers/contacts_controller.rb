class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params) #{name : 'asdf', email: 'asdf', comments: 'asdf'}
        if @contact.save # .save saves to our db
           redirect_to new_contact_path, notice: "Message sent." 
        else
            redirect_to new_contact_path, notice: "Error occured."
        end
    end
    
    private
        # This is a part of the create function ; Security feature
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end
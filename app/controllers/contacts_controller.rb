class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params) #{name : 'asdf', email: 'asdf', comments: 'asdf'}
        if @contact.save # .save saves to our db
            flash[:success] = "Message sent."
           redirect_to new_contact_path
        else
            # :error is how you call the key in this hash (dictionary)
            flash[:error] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    private
        # This is a part of the create function ; Security feature
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end
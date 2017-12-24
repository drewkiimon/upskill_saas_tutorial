class ContactsController < ApplicationController
    def new
        # Literally the form, and calls the page under view
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params) #{name : 'asdf', email: 'asdf', comments: 'asdf'}
        if @contact.save # .save saves to our db
            # :contact is key in param, then :name is key in contact hash
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            
            ContactMailer.contact_email(name, email, body).deliver
            flash[:success] = "Message sent."
            redirect_to new_contact_path
        else
            # :error is how you call the key in this hash (dictionary)
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    private
        # This is a part of the create function ; Security feature
        def contact_params
            # Params is hash, and adding a key with its own hash (:contact)
            params.require(:contact).permit(:name, :email, :comments)
        end
end
class ContactsController < ApplicationController
    # GET request to /contact-us (custom route)
    # Show new contact form to user
    def new
        # Literally the form, and calls the page under view
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignment of form fields into Contact object
        # {name : 'asdf', email: 'asdf', comments: 'asdf'}
        @contact = Contact.new(contact_params) 
        if @contact.save # .save saves to our db
            # Store form field withs params into variables
            # :contact is key in param, then :name is key in contact hash
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug variables into ContactMailer email meoth and send email
            ContactMailer.contact_email(name, email, body).deliver
            # Store success message in flash hash
            flash[:success] = "Message sent."
            # Redirect user to new_content_path
            redirect_to new_contact_path
        else
            # :error is how you call the key in this hash (dictionary)
            # If Contact object does not save, then store errors in flash hash
            # and redirect to new_contact_path
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    private
        # This is a part of the create function ; Security feature
        # To collect data from form, we need to use
        # strong parameters and whitelist the form fields
        def contact_params
            # Params is hash, and adding a key with its own hash (:contact)
            params.require(:contact).permit(:name, :email, :comments)
        end
end
class Contact < ActiveRecord::Base
    # Add new rules to Contact
    # Contact Form Validations
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end
class Contact < ActiveRecord::Base
    # Add new rules to Contact
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end
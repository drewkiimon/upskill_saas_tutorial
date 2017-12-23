Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  # Generates a bunch of URLs for us (we don't use them all)
  # REST / CRUD
  resources :contacts, only: :create
  # Reassigning to allow our old code to keep it's path in application.html.erb
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end

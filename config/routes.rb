Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  resources :entries do
    get :prolong, on: :collection
    get :receive, on: :collection
    post :close, on: :collection
    post :extend, on: :collection
    post :notify, on: :member
  end
  resources :employees
  resources :documents do
    get :add_new_document, on: :collection, as: :add_new
    post :reprint, on: :member
  end
  resources :barcodes
end

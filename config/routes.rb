Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  resources :requests do
    get :details, on: :member
    put :verify_documents, on: :member
    get :close, on: :member
    get :add_new_record, on: :collection
  end
  resources :entries do
    get :prolong, on: :collection
    get :receive, on: :collection
    post :close, on: :collection
    post :extend, on: :collection
    post :notify, on: :member
    put :check, on: :member
  end
  resources :employees do
    resources :entries, only: [:index]
  end
  resources :documents do
    get :add_new_document, on: :collection, as: :add_new
    post :reprint, on: :member
  end
  resources :barcodes

end

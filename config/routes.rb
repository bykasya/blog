Rails.application.routes.draw do
  resources :customers
  resources :posts do
    resources :comments
  end
    resources :pages
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

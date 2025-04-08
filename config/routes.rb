Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  
  authenticate :user do
    resources :transactions
  end
end

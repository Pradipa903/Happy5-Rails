Rails.application.routes.draw do
  resources :brands do
    resources :cars
  end
end
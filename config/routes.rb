SHS::Application.routes.draw do
  resources :news, :only => [:index]
end

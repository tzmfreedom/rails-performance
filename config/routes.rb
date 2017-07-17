Rails.application.routes.draw do
  root 'top#index'

  get '/partial_render', to: 'partial_render#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

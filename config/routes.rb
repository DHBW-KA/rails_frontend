Rails.application.routes.draw do
  resources :messages
  resources :users
  get 'ajax', to: 'system#ajax'
  get 'stimulus', to: 'system#stimulus'
  get 'vue', to: 'system#vue'
  get 'actioncable', to: 'system#actioncable'

  root 'system#ajax'
end

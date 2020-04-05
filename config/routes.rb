Rails.application.routes.draw do
  resources :messages
  resources :users
  get 'ajax', as: :ajax, to: 'system#ajax'
  get 'stimulus', as: :stimulus, to: 'system#stimulus'
  get 'vue', as: :vue, to: 'system#vue'
  get 'actioncable', as: :actioncable, to: 'system#actioncable'

  root 'system#ajax'
end

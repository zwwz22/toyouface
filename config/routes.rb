Abc::Application.routes.draw do
  get "applications/index"

  get "applications/create"

  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end

  root :to => 'homes#index'
  devise_for :users ,:controllers => {:sessions => :sessions,
                                      :registrations => :registrations
                                      }
  resources :homes



end

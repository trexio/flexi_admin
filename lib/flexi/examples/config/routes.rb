Rails.application.routes.draw do
  default_url_options Rails.application.config.action_mailer.default_url_options

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'inspections#index'

  get 'zasedacka', to: redirect(ENV.fetch('ZASEDACKA_URL', 'https://meet.google.com/zku-xddj-uud'))

  concern :resourceful do
    post :bulk_action, on: :collection
    get :datalist, on: :collection
    get :autocomplete, on: :collection
  end

  resources :uploads, only: %i[index create confirm] do
    post :initialize_upload, on: :collection
    post :soft_completed, on: :collection
  end

  resources :modals, only: [] do
    get :show, on: :collection
  end

  resources :playgrounds, concerns: :resourceful

  resources :elements, concerns: :resourceful

  resources :observations, concerns: :resourceful

  resources :inspections, concerns: :resourceful do
    get :import_protocol, on: :collection
    post :process_protocol_import, on: :collection
  end

  resources :observation_images, concerns: :resourceful

  resources :inspections, only: [] do
    resources :playground_statuses, controller: 'inspection/playground_statuses', concerns: :resourceful,
                                    only: [:edit] do
      put :update, on: :collection
    end

    resources :inspected_elements, controller: 'inspection/inspected_elements', concerns: :resourceful, only: [:edit] do
      put :update, on: :collection
    end

    resource :protocol, only: [:show]
  end
end

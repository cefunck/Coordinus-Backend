Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: [:show, :new, :edit]
      resources :client_services, except: [:show, :new, :edit]
      resources :schedule_days, except: [:show, :new, :edit]
      resources :schedule_time_ranges, except: [:show, :new, :edit]
      resources :shifts, except: [:show, :new, :edit]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # namespace :api do
  #   namespace :v1 do
  #     resources :users
  #     resources :client_services
  #     resources :schedule_days
  #     resources :schedule_time_ranges
  #     resources :shifts
  #   end
  # end
end

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "facilities#index"

  devise_for :users, path: "/", controllers: { confirmations: "confirmations" }
  resources :facilities

  # https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
  as :user do
    match "/confirmation" => "confirmations#update", via: :put, as: :update_user_confirmation
  end

  resources :users do
    member do
      post :resend_confirmation
      put :archive
      put :restore
    end
  end

  resource :locale, only: [:update]

  resources :languages
end

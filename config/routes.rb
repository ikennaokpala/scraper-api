Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, path: :v1, as: :v1 do
    resources :articles, only: [] do
      collection { resources :search, only: %i[index], module: :articles }
    end
  end
end

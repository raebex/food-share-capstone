Rails.application.routes.draw do
  namespace :api do
    post "/sessions" => "sessions#create"
    
    get "/users" => "users#index"
    get "/users/:id" => "users#show"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    get "/dishes/:id" => "dishes#show"
    post "/dishes" => "dishes#create"
    patch "/dishes/:id" => "dishes#update"
    delete "/dishes/:id" => "dishes#destroy"

    get "/cuisines" => "cuisines#index"

    post "/preorder_hours" => "preorder_hours#create"
    delete "/preorder_hours/:id" => "preorder_hours#destroy"

    get "/carted_dishes" => "carted_dishes#index"
    post "/carted_dishes" => "carted_dishes#create"
    patch "/carted_dishes/:id" => "carted_dishes#update"
    delete "/carted_dishes/:id" => "carted_dishes#destroy"
  end
end

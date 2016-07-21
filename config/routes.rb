Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tree, only: :index
  get 'tree/:id', to: 'roots#show', constraints: { id: /\d.+/ }

  scope do
    get(
      '/tree/*id',
      to: 'tree#show',
      constraints: { id: /.+/, format: /(html|js)/ },
      as: :tree
    )
  end

  root to: "tree#index"
end

Rails.application.routes.draw do

  devise_for :users
  root 'contents#index'

  constraints subdomain: 'api' do
    namespace :api, :path => '/' do
      namespace :v1 do
        resources :contents, only: [:index, :show] do
          member do 
            get 'subcontents'
          end
        end
        resources :sections, only: [:index, :show] do
          resources :contents, only: [:index]
        end
        resources :publishers, only: [:index] do
          resources :contents, only: [:index]
        end
      end
    end
  end

  resources :authors

  resources :sections do
    resources :contents
  end

  resources :contents do
    collection do
      get 'add' => 'contents#add'
    end

    member do
      patch 'publish' => 'contents#publish'
      patch 'revoke' => 'contents#revoke'
    end
    resources :article_body_images
    resources :photos

    resources :contents do
      collection do
        get 'add' => 'contents#add'
      end

      member do
        patch 'publish' => 'contents#publish'
        patch 'revoke' => 'contents#revoke'
      end
      resources :article_body_images
      resources :photos
    end
  end

  post 'article_body_image/delete' => 'article_body_images#destroy'

  #resources :sections do
  #  resources :contents
  #  resources :videos
  #end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :expense_payments

  resources :dashboard_chart do
    collection do
      get 'plot'
      get 'expense_balance'
      get 'expense_table'
      get 'table_plot'
    end
  end
  resources :paid_users
	devise_for :users
	devise_scope :user do
		authenticated :user do
			root 'expense_payments#index', as: :authenticated_root
		end

		unauthenticated do
			root 'devise/sessions#new', as: :unauthenticated_root
		end
	end
  get 'home/index'
  devise_for :views
end



  
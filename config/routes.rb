require 'sidekiq/web'

Ops::Engine.routes.draw do

  scope '/:locale' do
    resources :translations, except: :show do
      collection do
        post 'reload'
      end
    end

    resources :users, only: [:index]

    resources :notices, except: :show
    resources :leave_words, only:[:index, :destroy]

    %w(status).each {|e| get "site/#{e}"}
    %w(info seo engines).each do |e|
      get "site/#{e}"
      post "site/#{e}"
    end
    %w(nav).each do |e|
      get "site/#{e}"
      post "site/#{e}"
      put "site/#{e}"
    end
  end

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/jobs'
  end

  root 'site#engines'

end

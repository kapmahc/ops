require 'sidekiq/web'

Ops::Engine.routes.draw do
  resources :notices
  resources :leave_words, only:[:index, :destroy]

  %w(status engines).each {|e| get "site/#{e}"}
  %w(info seo).each do |e|
    get "site/#{e}"
    post "site/#{e}"
  end

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/jobs'
  end

  root 'site#status'

end

Ops::Engine.routes.draw do
  get 'dashboard' => 'home#dashboard'

  get 'site/base'
  root  'home#dashboard'
end

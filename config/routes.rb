Rails.application.routes.draw do
  get :golos, controller: :pages, action: :golos
  get :steem, controller: :pages, action: :steem

  post :search, controller: :pages, action: :search
  post :earnings, controller: :pages, action: :earnings
  post :witness, controller: :pages, action: :witness
  get :earnings, controller: :pages, action: :earnings
  get :witness, controller: :pages, action: :witness
  get :head_block, controller: :pages, action: :head_block

  root controller: :pages, action: :index
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :groups do
    resources :cards, shallow: true
  end
  get :quiz, to: 'quiz#index'
  post :quiz, to: 'quiz#init'
  get 'quiz/question', to: 'quiz#question', as: :quiz_question
  get 'quiz/end', to: 'quiz#end', as: :quiz_end
  post 'quiz/answer', to: 'quiz#answer', as: :quiz_answer
end

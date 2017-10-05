Rails.application.routes.draw do

  # These routes all deal with the administration of the system.
  post 'movies/:id' => 'movies#update'

  resources :users
  resources :login
  resources :stats, only: [:index]
  get  '/logout' => 'login#destroy'
  resources :admin_students

  # ---------------------------------------------------------------------------

  # This block of resources handles the entire process of a student
  # checking in -> verifying/adding info -> completing attendance.
  resources :events, except: [:edit] do
    resources :checkins, only: [:new, :create]
    resources :attendances
    resources :students  
  end

  # ---------------------------------------------------------------------------

  # This block handles stats
  get "/statistics/by_date" => 'statistics#by_date'
  get "/statistics/attendance" => 'statistics#attendance'
  get "/statistics/list" => 'statistics#list'
  get "/statistics/student/:id" => 'statistics#student'
  get "/statistics/school/:id" => 'statistics#school'
  resources :statistics
 
# ---------------------------------------------------------------------------


  root to: 'users#index'

end

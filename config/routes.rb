Rails.application.routes.draw do

  # These routes all deal with the administration of the system.
   post 'movies/:id' => 'movies#update'

  # resources :movies
  resources :users
  resources :login
  resources :stats, only: [:index]
  get  '/logout' => 'login#destroy'

  # ---------------------------------------------------------------------------

  # This block of resources handles the entire process of a student
  # checking in -> verifying/adding info -> completing attendance.
  resources :events, except: [:edit] do
    resources :checkins, only: [:new, :create]
    resources :attendances #, only: [:new, :create]
    resources :students  #, only: [:show, :new, :edit, :create, :update]s
  end

  # ---------------------------------------------------------------------------

  # This block handles charts
  get "/statistics/by_date" => 'statistics#by_date'
  get "/statistics/attendance" => 'statistics#attendance'
  get "/statistics/list" => 'statistics#list'
  get "/statistics/student/:id" => 'statistics#student'
  get "/statistics/school/:id" => 'statistics#school'
  resources :statistics
  resources :charts, only: [] do
    collection do
      get 'attendances_by_date'
      get 'referrals_by_date'
      get 'movies_by_date'
      get 'schools_by_date'
      get 'grade_by_date'
      get 'zip_by_date'
      get 'school_trends'
      get 'attendances_all_time'
    end
  end
 
# ---------------------------------------------------------------------------


  root to: 'users#index'

  # Why do i have to add this manually?
  post "/events/:id/attendances/create" => 'attendances#create'
end

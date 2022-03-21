Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'home#index'
  get 'home/about'

  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  devise_for :instructors, controllers: { registrations: 'instructors/registrations' }
  devise_for :students, controllers: { registrations: 'students/registrations' }

  resources :instructors do
    resources :courses
  end

  get '/admins', to: 'admins#index', as: :admin_root
  get '/students', to: 'students#index', as: :student_root
  get '/instructors', to: 'instructors#index', as: :instructor_root
  get 'admins/instructors', to: 'admins#instructors', as: :admin_instructors
  get 'admins/courses', to: 'admins#courses', as: :admin_courses
  get 'admins/students', to: 'admins#students', as: :admin_students
  get 'courses/enrolled', to: 'courses#enrolled', as: :course_enrolled_students
  get 'courses/enroll', to: 'courses#enroll', as: :course_enroll_students
  resources :courses
  resources :enrolls, only: %i[create destroy]
  resources :students, except: [:show]
end
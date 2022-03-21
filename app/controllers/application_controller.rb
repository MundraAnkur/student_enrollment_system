class ApplicationController < ActionController::Base
  devise_group :member, contains: %i[admin instructor student]
end

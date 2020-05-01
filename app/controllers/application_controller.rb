class ApplicationController < ActionController::Base
  #make sure a user is signed in
  before_action :authenticate_user!
end

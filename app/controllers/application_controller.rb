class ApplicationController < ActionController::Base
  # include Pundit::Authorization
  include Pagy::Backend
  include SortOrder
end

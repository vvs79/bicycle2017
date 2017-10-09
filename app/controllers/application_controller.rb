class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :all_categories

  private
    def all_categories
      @categories = Category.all
    end

    def check_if_admin
      redirect_to bikes_path, notice: 'Access Denied' unless user_signed_in? && current_user.admin?
    end
end

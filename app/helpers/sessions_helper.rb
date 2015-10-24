module SessionsHelper

  ## This logs in the given user
  def log_in(user)
    session[:user_id] = @user_id
  end

    ## This returns the current logged in user if exists
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  ## True if a user is logged in, else false
  def logged_in?
    !@current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end

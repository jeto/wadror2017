class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by username: params[:username]
    session[:user_id] = user.id if user
    redirect_to :root
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
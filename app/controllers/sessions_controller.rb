class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user.banned
      redirect_to :back, alert: "You have been banned"
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back #{user.username}!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def create_oauth
    authhash = env["omniauth.auth"].info

    user = User.find_by username:"#{authhash.nickname}"
    unless user.nil?
      if user.banned
        redirect_to :back, alert: "You have been banned"
        return
      end
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back #{user.username}!"
    else
      account = User.create! username: authhash.nickname, oauth: true
      session[:user_id] = account.id
      redirect_to user_path(account)
    end
  end
end
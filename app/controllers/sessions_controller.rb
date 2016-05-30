class SessionsController < ApplicationController
  def create
    event = Event.find_by(slug: (env['omniauth.params'] || session['omniauth.params'])['event'])
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    if event
      redirect_to event_checkin_path(event)
    else
      redirect_to edit_user_path
    end
  end

  def new
    redirect_to edit_user_path if current_user
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end

class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'facebook')
    if @user.nil?
      @user = User.build_from_facebook(auth_hash)
      flash[:notice] = "Unable to save the User"
      return redirect_to root_path unless @user.save
    end
    session[:user_id] = @user.id

    redirect_to root_path
  end


  # begin
  #   render text: request.env['omniauth.auth'].to_yaml
  #   session[:user_id] = @user.id
  #   flash[:success] = "Welcome, #{@user.name}!"
  # rescue
  #   flash[:warning] = "There was an error while trying to authenticate you..."
  # end
  # redirect_to root_path



  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end
end


# def create
#   auth_hash = request.env['omniauth.auth']
#   redirect_to login_failure_path unless auth_hash['uid']
#
#   @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
#   if @user.nil?
#     @user = User.build_from_github(auth_hash)
#     flash[:notice] = "Unable to save the User"
#     render :creation_failure unless @user.save
#   end
#
#   session[:user_id] = @user.id
#
#   redirect_to tasks_path
# end

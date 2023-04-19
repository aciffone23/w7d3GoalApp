class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create

        # we have params - username, password
        # find user - User.find_by_credentials(username, password)
        # login a user
        # redirect them somewhere

        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by_credentials(username, password)

        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(username: username)
            flash.now[:errors] = ["Invalid Credentials"]
            render :new, status: 422
        end
    end

    def destroy
        logout! if current_user
        session[:session_token] = nil
        render :new
    end
end

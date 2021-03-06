class Api::V1::UsersController < ApplicationController
  # before_action :set_user

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: get_current_user
  end

  def show_by_username
    @user = User.find_by(username: params[:username])
    render json: @user
  end

  def fetch_user
    render json: get_current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      jwt = Auth.encrypt({ user_id: @user.id })
      render json: { jwt: jwt, user: @user }
    else
      render json: {
        error: "User failed to create",
        status: 400
      }, status: 400
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      jwt = Auth.encrypt({ user_id: @user.id })
      render json: { jwt: jwt, user: @user }
    else
      render json: {
        error: "Username or Password Incorrect",
        status: 400
      }, status: 400
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: 400
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :password, :password_confirmation, :first_name, :last_name, :email, :avatar)
    end
end

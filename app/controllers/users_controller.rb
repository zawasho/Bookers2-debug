class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit,:update]}

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def new
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(current_user.id)
    else
      render "/users/_sign_up"
    end
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  	@user.update(user_params)
    if @user.save
      flash[:notice] = "Profile was successfully updated."
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
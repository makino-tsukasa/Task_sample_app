class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index]
  before_action :admin_or_correct_user, only: [:show]
  before_action :already_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    log_in @user
    flash[:success] = '新規作成に成功しました。'
    redirect_to @usr
  end

  def show
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}の情報を更新しました。"
      redirect_to @user
    else
      flash[:danger] = "情報を更新できませんでした。"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "#{@user.name}を削除しました。"
      redirect_to users_url
    else
      flash[:danger] = "#{@user.name}を削除できませんでした。"
      render :index
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end

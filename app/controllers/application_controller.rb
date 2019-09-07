class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  # ログイン済みのユーザーか確認します。
  def already_logged_in
    if logged_in?
      flash[:danger] = "すでにログインしています。"
      redirect_to current_user
    end
  end
  
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    redirect_to(root_url) unless @user == current_user
  end
  
  def admin_user
    unless current_user.admin?
    flash[:danger] = "管理ユーザー以外権限がありません。"
    redirect_to(root_url)
    end
  end
  
  def admin_or_correct_user
    unless @user == current_user || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to(root_url)
    end
  end
end

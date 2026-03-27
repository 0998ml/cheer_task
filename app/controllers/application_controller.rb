class ApplicationController < ActionController::Base
  # どこからでも current_user と呼べば、ログイン中のユーザー情報を返してくれるようにする
  helper_method :current_user, :logged_in?

  private

  def current_user
    # セッションにIDがあれば、そのユーザーを探して持っておく
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  # ログインしていない場合にログイン画面へ飛ばす
  def authenticate_user
    if current_user.nil?
      redirect_to login_path, alert: "ログインが必要です"
    end
  end

  def require_admin
    # 「ログインしていない」または「管理者（admin）が true じゃない」場合はトップページに追い出す
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "管理者権限がありません。"
    end
  end

end

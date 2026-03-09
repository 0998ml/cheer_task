class ApplicationController < ActionController::Base
  # どこからでも current_user と呼べば、ログイン中のユーザー情報を返してくれるようにする
  helper_method :current_user

  private

  def current_user
    # セッションにIDがあれば、そのユーザーを探して持っておく
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ログインしていない場合にログイン画面へ飛ばす
  def authenticate_user
    if current_user.nil?
      redirect_to login_path, alert: "ログインが必要です"
    end
  end
end

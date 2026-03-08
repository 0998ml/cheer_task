class SessionsController < ApplicationController
  def new
  end

  def create
    # 1. 送られてきたメールアドレスでユーザーを探す
    user = User.find_by(email: params[:session][:email])

    # 2. ユーザーが存在し、かつパスワードが正しいかチェック
    if user && user.authenticate(params[:session][:password])
      # 3. ログイン成功：セッションにユーザーIDを保存
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      # 4. ログイン失敗：エラーメッセージを表示して再描画
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # セッションからユーザーIDを消す（ログアウト）
    session.delete(:user_id)
    redirect_to root_path, notice: "ログアウトしました", status: :see_other
  end
end
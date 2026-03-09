class UsersController < ApplicationController
  # ログインしてないとアクセスできないようにする
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      # 失敗したとき、新規登録画面を再表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @tasks = @user.tasks  #ログインユーザーの投稿一覧を取得
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user 
    # 氏名、メールアドレスを更新
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザー情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    #物理削除
    @user.destroy
    #サインアップ画面へ
    reset_session
    redirect_to signup_path, notice: "退会処理が完了しました", status: :see_other
  end

private

  def user_params
    # パスワードは更新しない場合も考慮しつつ、必要な項目を許可
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
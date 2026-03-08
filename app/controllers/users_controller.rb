class UsersController < ApplicationController
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

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
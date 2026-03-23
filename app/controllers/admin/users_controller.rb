class Admin::UsersController < ApplicationController
  # このコントローラーのすべてのアクションの前に `require_admin` を実行する
  before_action :require_admin

  def index
    # 管理者画面なので、登録されているすべてのユーザーを取得する
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.name}を強制退会させました。"
  end
end

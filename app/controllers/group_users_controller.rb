class GroupUsersController < ApplicationController
  def create
    @group_user = GroupUser.new(group_user_params)
    @group_user.status = 0 # 最初は「招待中」で保存
    if @group_user.save
      redirect_back(fallback_location: users_path, notice: "ユーザーを招待しました")
    else
      redirect_back(fallback_location: users_path, alert: "招待に失敗しました")
    end
  end

  def update
    @group_user = GroupUser.find(params[:id])
    if @group_user.update(status: 1)
      redirect_back(fallback_location: root_path, notice: "グループに参加しました")
  else
    else
      redirect_back(fallback_location: root_path, alert: "承認に失敗しました")
    end
  end

  # 招待を拒否する（データを消す）
  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy
    redirect_back(fallback_location: root_path), notice: "招待を拒否しました"
  end

  private

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id)
  end
end
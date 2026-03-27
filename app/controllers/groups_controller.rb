class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @group = Group.new # 新規作成用
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to tasks_path, status: :see_other, notice: "グループを作成しました"
    else
      @groups = Group.all
      redirect_to tasks_path, status: :see_other, alert: "グループ作成に失敗しました"
    end
  end

  def show
    @group = Group.find(params[:id])
    # このグループに紐付いているタスクだけを表示するため
    @tasks = @group.tasks
  end

  def destroy
    @group = Group.find(params[:id])

    if current_user.admin?
      @group.destroy
      redirect_to tasks_path, status: :see_other, notice: "グループ「#{@group.name}」を削除しました"
    else
      redirect_to tasks_path, status: :see_other, alert: "管理者権限がありません"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
class GroupsController < ApplicationController
  # 対象のグループ(@group)を見つけてくる
  before_action :set_group, only: [:show, :destroy]

  def index
    @groups = Group.all
    @group = Group.new # 新規作成用
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to tasks_path, status: :see_other, notice: "グループを作成しました"
    else
      # renderの時は「flash.now」を使って、今の画面だけにメッセージを出す
      flash.now[:alert] = "グループ作成に失敗しました"

      @tasks = Task.includes(:user).all
      @groups = Group.all
      render 'tasks/index', status: :unprocessable_entity
    end
  end

  def show
    # このグループに紐付いているタスクだけを表示するため
    @tasks = @group.tasks
  end

  def destroy
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

  def set_group
    @group = Group.find(params[:id])
  end

end
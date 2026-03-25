class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @group = Group.new # 新規作成用
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: "グループを作成しました"
    else
      @groups = Group.all
      render :index, status: :unprocessable_entity
    end
  end


  
  def show
    @group = Group.find(params[:id])
    # このグループに紐付いているタスクだけを表示するため
    @tasks = @group.tasks
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
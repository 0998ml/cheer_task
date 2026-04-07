class Admin::TasksController < ApplicationController
  before_action :require_admin # 管理者以外は弾く

  def index
    @tasks = Task.all.includes(:user) # 全タスクを取得
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to admin_tasks_path, notice: "タスク「#{@task.title}」を強制削除しました。"
  end
end
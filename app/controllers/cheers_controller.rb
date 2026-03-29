class CheersController < ApplicationController
  # 1. 共通の「タスク探し」を、アクションが動く前に実行
  before_action :set_task, only: [:create, :destroy]

  def create
    
    # current_user（自分）のcheersとして新しいデータを作る
    cheer = current_user.cheers.new(task_id: @task.id)
    cheer.save

    redirect_back(fallback_location: tasks_path)
  end

  def destroy
    
    # 自分のcheersの中から、このタスクにつけたCheerを探して削除する
    cheer = current_user.cheers.find_by(task_id: @task.id)
    cheer.destroy

    redirect_back(fallback_location: tasks_path)
  end

  private

  def set_task 
    @task = Task.find(params[:task_id])
  end
end

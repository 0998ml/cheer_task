class CheersController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    # current_user（自分）のcheersとして新しいデータを作る
    cheer = current_user.cheers.new(task_id: @task.id)
    cheer.save

    redirect_back(fallback_location: tasks_path)
  end

  def destroy
    @task = Task.find(params[:task_id])
    # 自分のcheersの中から、このタスクにつけたCheerを探して削除する
    cheer = current_user.cheers.find_by(task_id: @task.id)
    cheer.destroy

    redirect_back(fallback_location: tasks_path)
  end
end

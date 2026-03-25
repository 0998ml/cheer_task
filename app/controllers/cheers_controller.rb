class CheersController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    # current_user（自分）のcheersとして新しいデータを作る
    cheer = current_user.cheers.new(task_id: @task.id)
    cheer.save
    # 元の画面（タスク一覧や詳細）に戻る
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

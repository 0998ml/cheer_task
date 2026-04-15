class TasksController < ApplicationController
  # 全アクションの前に、まずはログインしているかチェック
  before_action :authenticate_user

  # 対象のタスク（@task）を見つけてくる（show, edit, update, destroyで共通）
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # 編集・更新・削除の前に、本人の投稿かチェック
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    # 検索してもしなくても、サイドバーなどで使うこれらは「常に」必要！
    @groups = Group.all
    @group = Group.new
    
    # 5行あったif文を、三項演算子でスッキリ1行に！
    # 「検索ワードがある？ ? (あるなら)検索する : (ないなら)全部出す」
    @tasks = params[:search].present? ? Task.includes(:user).search_by_keyword(params[:search]) : Task.includes(:user).all
  end

  def show
    # set_taskが動くので、空
  end

  def new
    @task = Task.new # 新規投稿用の空の箱を作る
  end

  def edit
    #すでに @task が準備されている
  end

  def create
    # 現在のユーザーに紐付いたタスクを作成
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      #直前のページのURLに戻す　
      redirect_back_or_to tasks_path(anchor: "task_#{@task.id}"), notice: "タスクを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました。", status: :see_other  #DELETE じゃなくて、普通の GET でアクセス
  end
  
  private

  def task_params
    params.require(:task).permit(:title, :body, :status, :group_id)
  end

  # 【新規追加】タスクを見つける専属のメソッド
  def set_task
    @task = Task.find(params[:id])
  end

  def ensure_correct_user
    if @task.user_id != current_user.id
      redirect_to tasks_path, alert: "権限がありません"
    end
  end
end

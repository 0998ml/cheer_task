class TasksController < ApplicationController
  # 全アクションの前に、まずはログインしているかチェック
  before_action :authenticate_user

  # 編集・更新・削除の前に、本人の投稿かチェック
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    # もし検索キーワードが入力されていたら
    if params[:search].present?
      # タイトル(title) か 本文(body) のどちらかにキーワードが含まれるものを探す
      @tasks = Task.where('title LIKE ? OR body LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      # 検索されていない時は、今まで通りすべてのタスクを表示する
      @tasks = Task.all #すべてのタスクを取得して、一覧に表示
      @groups = Group.all
      @group = Group.new
    end
  end

  def show
    @task = Task.find(params[:id]) # 特定のタスクを1件取得
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
      redirect_to "#{request.referer.split('#').first}#task_#{@task.id}"
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

  def ensure_correct_user
    @task = Task.find(params[:id])
    if @task.user_id != current_user.id
      redirect_to tasks_path, alert: "権限がありません"
    end
  end
end

class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    # 送られてきたコメントの内容と、現在ログインしているユーザーを紐付けて作成
    @comment = current_user.comments.new(comment_params)
    @comment.task_id = @task.id # どのタスクへのコメントかも紐付ける

    if @comment.save
      # 保存できたら元の画面に戻る
      redirect_back(fallback_location: task_path(@task))
    else
      # もし保存に失敗した場合も元の画面に戻る
      redirect_back(fallback_location: task_path(@task))
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    # 自分がしたコメントなら削除できる
    if @comment.user_id == current_user.id
      @comment.destroy
    end
    redirect_back(fallback_location: task_path(@comment.task))
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
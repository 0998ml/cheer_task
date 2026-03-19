class HomesController < ApplicationController
  # 「top」と「about」アクションだけは、ログインチェックをスキップする
  before_action :authenticate_user!, except: [:top, :about]

  def top
  end

  def about
  end
end

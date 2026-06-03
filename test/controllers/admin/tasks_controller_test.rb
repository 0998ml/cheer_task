require "test_helper"

module Admin
  class TasksControllerTest < ActionDispatch::IntegrationTest
    test "ログインしていないと管理者タスク一覧を見られない" do
      get admin_tasks_path
      assert_redirected_to login_path
    end
  end
end
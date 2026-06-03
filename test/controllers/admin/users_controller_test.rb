require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "ログインしていないと管理者user一覧を見れない" do
    get admin_users_path
    assert_redirected_to login_path
  end
end

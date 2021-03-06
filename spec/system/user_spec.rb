require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'ユーザ登録のテスト' do
    context 'ユーザの新規登録した場合' do
      it '作成したユーザーログインできる' do
        visit new_user_path
        fill_in "user[name]", with:"test_name"
        fill_in "user[email]", with:"test_email@gmail.com"
        fill_in "user[password]", with:"test_password"
        fill_in "user[password_confirmation]", with:"test_password"
        click_on "アカウントを作る"
        expect(page).to have_content 'test_nameのページ'
      end
    end  
    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
end
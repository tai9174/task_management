require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }


  describe '管理画面のテスト' do
    context '管理画面へを押すと' do
      it '管理画面にアクセスできる' do
        visit sessions_new_path
        fill_in "session[email]", with:"admin_email@gmail.com"
        fill_in "session[password]", with:"admin_password"
        click_on "ログイン"
        click_on "管理画面へ"
        expect(page).to have_content 'ユーザー 一覧'
      end
    end
    context '一般ユーザが管理画面にアクセスしようとする場合' do
      it '管理者以外はアクセスできません' do
        visit sessions_new_path
        fill_in "session[email]", with:"test_email@gmail.com"
        fill_in "session[password]", with:"test_password"
        click_on "ログイン"
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end

    before do
        visit sessions_new_path
        fill_in "session[email]", with:"admin_email@gmail.com"
        fill_in "session[password]", with:"admin_password"
        click_on "ログイン"
    end

    context '管理ユーザがユーザの新規登録する場合' do
      it 'ユーザの新規登録ができる' do
        click_on "管理画面へ"
        click_on "新規ユーザーを作成"
        select "false", from:"user[admin]"
        fill_in "user[name]", with:"test3_name"
        fill_in "user[email]", with:"test3_email@gmail.com"
        fill_in "user[password]", with:"test3_password"
        fill_in "user[password_confirmation]", with:"test3_password"
        click_on "ユーザー作成"
        expect(page).to have_content 'ユーザーを作成しました'
      end
    end
    context '管理ユーザがユーザの詳細画面にアクセスした場合' do
      it 'ユーザの詳細画面にアクセスができる' do
        click_on "管理画面へ"
        visit admin_user_path (User.find(101))
        expect(page).to have_content '[test_nameのタスク一覧]'
      end
    end
    context '管理ユーザがユーザ編集画面にアクセスした場合' do
      it 'ユーザを編集できる' do
        click_on "管理画面へ"
        visit edit_admin_user_path (User.find(101))
        select "false", from:"user[admin]"
        fill_in "user[name]", with:"test4_name"
        fill_in "user[email]", with:"test4_email@gmail.com"
        fill_in "user[password]", with:"test4_password"
        fill_in "user[password_confirmation]", with:"test4_password"
        click_on "ユーザー作成"
        expect(page).to have_content 'test4_nameのページ'
      end
    end
    context '管理ユーザがユーザを削除した場合' do
      it 'ユーザが削除できる' do
        click_on "管理画面へ"
        click_on "削除", match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'user は削除されました！'
      end
    end
  end
end
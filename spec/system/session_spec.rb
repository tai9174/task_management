require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit sessions_new_path
    fill_in "session[email]", with:"test_email@gmail.com"
    fill_in "session[password]", with:"test_password"
    click_on "ログイン"
  end

  describe 'セッション機能のテスト' do
    context 'ログインした場合' do
      it 'マイページに飛ぶ' do
        expect(page).to have_content 'test_nameのページ'
      end
    end
    context '他人の詳細画面に飛ぶ場合' do
      it 'タスク一覧画面に遷移する' do
        click_on "ログアウト"
        FactoryBot.create(:second_user ) 
        fill_in "session[email]", with:"test_email2@gmail.com"
        fill_in "session[password]", with:"test_password2"
        click_on "ログイン"
        visit  user_path (User.find(101))
        expect(page).to have_content 'test_name2のタスク一覧'
      end
    end
    context 'ログアウト飛ぶ場合' do
      it 'ログアウトしましたが表示する' do
        click_on "ログアウト"
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
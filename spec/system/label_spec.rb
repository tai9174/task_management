require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }

  describe 'ラベル機能のテスト' do
    context '管理者がラベルを登録する場合' do
      it 'ラベルが作成できる' do
        visit sessions_new_path
        fill_in "session[email]", with:"admin_email@gmail.com"
        fill_in "session[password]", with:"admin_password"
        click_on "ログイン"
        visit new_label_path
        fill_in "label[name]", with:"label_name"
        click_on "登録する"
        expect(page).to have_content 'label_name'
      end
    end  

    context '管理者以外がラベル一覧に飛ぼうとする場合' do
      it '管理者以外はアクセスできませんを表示する' do
        visit sessions_new_path
        fill_in "session[email]", with:"test_email@gmail.com"
        fill_in "session[password]", with:"test_password"
        click_on "ログイン"
        visit labels_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end

    before do
      visit sessions_new_path
      fill_in "session[email]", with:"test_email@gmail.com"
      fill_in "session[password]", with:"test_password"
      click_on "ログイン"
    end

    context 'ラベルを登録する場合' do
      it '複数のラベルが登録される' do
        visit new_task_path
        fill_in "task[title]", with:"test_title"
        fill_in "task[content]", with:"test_content"
        select "未着手", from:"task[status]"
        select "低", from:"task[priority]"
        check"A"
        check"B"
        click_on "登録する"   
        click_on "戻る"
        expect(page).to have_content 'A'
        expect(page).to have_content 'B'
      end
    end
    context 'ラベル検索をした場合' do
      it "完全一致するラベルに絞り込まれる" do
        FactoryBot.create(:task, title: "test", status: "着手中", user: user)
        FactoryBot.create(:second_task, title: "sample", status: "未着手", user: user)
        click_on "タスク一覧へ"
        click_on "編集", match: :first
        check "B"
        click_on "更新する"
        click_on "戻る"
        select "B", from:"search[label_id]"
        click_on "検索する" 
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'B'
        expect(task_list[1]).to have_content ''
      end
    end        
  end
end
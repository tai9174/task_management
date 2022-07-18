require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'test_title') }
  before do
    # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do        
        visit new_task_path
        fill_in "task[title]", with:"test_title"
        fill_in "task[content]", with:"test_content"
        fill_in "task[expired_at]", with:"002022-07-15"
        fill_in "task[status]", with:"test_content"
        click_on "登録する"        
        expect(page).to have_content 'test_title'
      end
    end
  end

  # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #       task = FactoryBot.create(:task, title:"test_title")
  #       visit tasks_path
  #       expect(page).to have_content 'test_title'
  #     end
  #   end
  #   # テスト内容を追加で記載する
  #   context 'タスクが作成日時の降順に並んでいる場合' do
  #     it '新しいタスクが一番上に表示される' do
  #       FactoryBot.create(:task, title:"test_title")
  #       FactoryBot.create(:task, title:"test_title2")
  #       visit tasks_path
  #       task_list = all('.task_row')
  #       expect(task_list[0]).to have_content 'test_title2'
  #       expect(task_list[1]).to have_content 'test_title'
  #     end
  #   end 
  # end


  # describe '詳細表示機能' do
  #   context '任意のタスク詳細画面に遷移した場合' do
  #     it '該当タスクの内容が表示される' do
  #       task = FactoryBot.create(:task, title:"test_title")
  #       visit task_path(task.id)
  #       expect(page).to have_content 'test_title'
  #     end
  #   end
  # end
end

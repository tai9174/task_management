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
        select "未着手", from:"task[status]"
        select "低", from:"task[priority]"
        click_on "登録する"        
        expect(page).to have_content 'test_title'
      end
    end 
    context '終了期限でソートした場合' do
      it '終了期限で降順に一覧が表示される' do
        FactoryBot.create(:task ) 
        FactoryBot.create(:second_task )
        visit tasks_path
        click_on '終了期限'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_title2'
        expect(task_list[1]).to have_content 'test_title'
      end
    end
    context '優先順位でソートした場合' do
      it '優先順位で降順に一覧が表示される' do
        FactoryBot.create(:task ) 
        FactoryBot.create(:second_task )
        visit tasks_path
        click_on '優先度'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_title2'
        expect(task_list[1]).to have_content 'test_title'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title:"test_title")
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end

    # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, title:"test_title", created_at:Date.today)
        FactoryBot.create(:task, title:"test_title2",content:"test_content2", created_at:Date.today+1)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_title2'
        expect(task_list[1]).to have_content 'test_title'
      end
    end 
  end


  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title:"test_title")
        visit task_path(task.id)
        expect(page).to have_content 'test_title'
      end
    end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        FactoryBot.create(:task, title: "test", status: "着手中")
        FactoryBot.create(:second_task, title: "sample", status: "未着手")
        visit tasks_path
        fill_in "search[title]", with:"t"
        task_list = all('.task_row')
        click_on "検索する" 
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_title'
        expect(task_list[1]).to have_content 'test'
        expect(task_list[2]).to have_content ''
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        FactoryBot.create(:task, title: "test", status: "着手中")
        FactoryBot.create(:second_task, title: "sample", status: "未着手")
        visit tasks_path
        select "未着手", from:"search[status]"
        click_on "検索する" 
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '未着手'
        expect(task_list[1]).to have_content ''
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        FactoryBot.create(:task, title: "test", status: "着手中")
        FactoryBot.create(:second_task, title: "sample", status: "未着手")
        FactoryBot.create(:third_task, title: "test", status: "未着手")
        visit tasks_path
        fill_in "search[title]", with:"t"
        select "未着手", from:"search[status]"
        click_on "検索する" 
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test'
        expect(task_list[0]).to have_content '未着手'
        expect(task_list[1]).to have_content ''
      end
    end

  end
end

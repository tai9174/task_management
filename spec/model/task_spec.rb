require 'rails_helper'
describe 'タスクモデル機能', type: :model do

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト',priority: 1,status: 1,expired_at: Date.today)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title:'失敗テスト', content:'',priority: 1,status: 1,expired_at: Date.today)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title:'成功タイトル名',content:'成功詳細',priority: 1,status: 1,expired_at: Date.today)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task',status: "着手中") }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample",status: "未着手") }
    let!(:third_task) { FactoryBot.create(:third_task, title: "task",status: "未着手") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(second_task)
        expect(Task.search_title('task')).to include(third_task)
        expect(Task.search_title('task').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).not_to include(task)
        expect(Task.search_status('未着手')).to include(second_task)
        expect(Task.search_status('未着手')).to include(third_task)
        expect(Task.search_status('未着手').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task').search_status('未着手')).not_to include(task)
        expect(Task.search_title('task').search_status('未着手')).not_to include(second_task)
        expect(Task.search_title('task').search_status('未着手')).to include(third_task)
        expect(Task.search_title('task').search_status('未着手').count).to eq 1
      end
    end
  end
end

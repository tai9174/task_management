# 「FactoryBotを使用します」という記述
FactoryBot.define do
  factory :task, class: Task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at{Date.today}
    created_at{Date.today}
    status{1}
    priority{0}
  end

  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    expired_at{Date.today+1}
    created_at{Date.today+1}
    status{1}
    priority{1}
  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    expired_at{Date.today+5}
    created_at{Date.today+5}
    status{1}
    priority{2}
  end
end

# fill_in "task[title]", with:"test_title"
#         fill_in "task[content]", with:"test_content"
#         fill_in "task[expired_at]", with:"002022-07-15"
#         fill_in "task[status]", with:"test_content"
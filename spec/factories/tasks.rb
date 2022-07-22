FactoryBot.define do
  factory :task, class: Task do
    user
    title { 'test_title' }
    content { 'test_content' }
    expired_at{Date.today}
    created_at{Date.today}
    status{1}
    priority{1}
  end

  factory :second_task, class: Task do
    user
    title { 'test_title2' }
    content { 'test_content2' }
    expired_at{Date.today+1}
    created_at{Date.today+1}
    status{1}
    priority{0}
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

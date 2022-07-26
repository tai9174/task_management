FactoryBot.define do
  factory :label do
    name { "A" }
  end
  
  factory :second_label , class: Label do
    name { "B" }
  end

  factory :third_label , class: Label do
    name { "C" }
  end
end
